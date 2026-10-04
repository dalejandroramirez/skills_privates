#!/usr/bin/env bash

set -euo pipefail

REPO_URL="${SKILLS_REPO_URL:-git@github.com:dalejandroramirez/skills_privates.git}"
BRANCH="${SKILLS_BRANCH:-master}"
TARGET_DIR=".agents/skills"

TMP_DIR=""


cleanup() {
    if [[ -n "${TMP_DIR:-}" && -d "$TMP_DIR" ]]; then
        rm -rf "$TMP_DIR"
    fi
}

trap cleanup EXIT


prepare_repository() {

    TMP_DIR="$(mktemp -d)"

    echo "Preparando skills_privates..."
    echo "Repositorio: $REPO_URL"
    echo "Branch: $BRANCH"
    echo ""

    # Repositorio local
    if [[ -d "$REPO_URL" && -f "$REPO_URL/registry.json" ]]; then

        echo "Repositorio local detectado."

        mkdir -p "$TMP_DIR/skills_privates"

        cp -R "$REPO_URL/." \
            "$TMP_DIR/skills_privates/"

    else

        # Repositorio remoto
        echo "Repositorio remoto detectado."

        git clone \
            --depth 1 \
            --branch "$BRANCH" \
            "$REPO_URL" \
            "$TMP_DIR/skills_privates"

    fi


    if [[ ! -f "$TMP_DIR/skills_privates/registry.json" ]]; then

        echo ""
        echo "ERROR: registry.json no encontrado."
        echo ""

        find "$TMP_DIR/skills_privates" \
            -maxdepth 3 \
            -type f \
            | sort

        exit 1
    fi

    echo "Repositorio preparado."
    echo ""
}


get_skill_path() {

    python3 \
        "$TMP_DIR/skills_privates/scripts/get_skill.py" \
        "$1"
}


get_profile_skills() {

    python3 \
        "$TMP_DIR/skills_privates/scripts/get_profile.py" \
        "$1"
}


install_skill() {

    local skill_name="$1"

    local skill_path
    local source
    local destination

    skill_path="$(get_skill_path "$skill_name")"

    source="$TMP_DIR/skills_privates/$skill_path"

    destination="$TARGET_DIR/$skill_name"


    if [[ ! -f "$source/SKILL.md" ]]; then

        echo ""
        echo "ERROR: Skill inválida:"
        echo "$skill_name"
        echo ""

        exit 1
    fi


    echo "Instalando: $skill_name"

    mkdir -p "$TARGET_DIR"

    rm -rf "$destination"

    cp -R "$source" "$destination"

    echo "  ✓ $destination"
}


install_profile() {

    local profile="$1"

    echo "Instalando perfil: $profile"
    echo ""

    while IFS= read -r skill; do

        [[ -z "$skill" ]] && continue

        install_skill "$skill"

    done < <(
        get_profile_skills "$profile"
    )
}


list_skills() {

    python3 - \
        "$TMP_DIR/skills_privates/registry.json" <<'PY'

import json
import sys

path = sys.argv[1]

with open(path, "r", encoding="utf-8") as file:
    registry = json.load(file)

print()
print("Skills:")
print()

for name, path in registry["skills"].items():
    print(f"  {name}")

print()
print("Profiles:")
print()

for name in registry["profiles"]:
    print(f"  {name}")

print()

PY
}


usage() {

    echo ""
    echo "Uso:"
    echo ""
    echo "  ./install.sh list"
    echo "  ./install.sh skill <skill>"
    echo "  ./install.sh profile <profile>"
    echo ""
}


main() {

    case "${1:-}" in

        list)

            prepare_repository
            list_skills
            ;;

        skill)

            [[ -n "${2:-}" ]] || {
                usage
                exit 1
            }

            prepare_repository
            install_skill "$2"
            ;;

        profile)

            [[ -n "${2:-}" ]] || {
                usage
                exit 1
            }

            prepare_repository
            install_profile "$2"
            ;;

        *)

            usage
            exit 1
            ;;

    esac

    echo "Proceso completado correctamente."
}


main "$@"
