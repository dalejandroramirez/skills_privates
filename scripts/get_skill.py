import json
import sys
from pathlib import Path


def main() -> None:
    if len(sys.argv) != 2:
        raise SystemExit("Uso: get_skill.py <skill>")

    skill_name = sys.argv[1]

    root = Path(__file__).resolve().parent.parent
    registry_path = root / "registry.json"

    with registry_path.open("r", encoding="utf-8") as file:
        registry = json.load(file)

    skills = registry.get("skills", {})

    if skill_name not in skills:
        raise SystemExit(
            f"La skill '{skill_name}' no existe en skills_privates."
        )

    print(skills[skill_name])


if __name__ == "__main__":
    main()
