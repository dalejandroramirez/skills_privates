import json
import sys
from pathlib import Path


def main() -> None:
    if len(sys.argv) != 2:
        raise SystemExit("Uso: get_profile.py <profile>")

    profile_name = sys.argv[1]

    root = Path(__file__).resolve().parent.parent
    registry_path = root / "registry.json"

    with registry_path.open("r", encoding="utf-8") as file:
        registry = json.load(file)

    profiles = registry.get("profiles", {})

    if profile_name not in profiles:
        raise SystemExit(
            f"El perfil '{profile_name}' no existe en skills_privates."
        )

    for skill in profiles[profile_name]:
        print(skill)


if __name__ == "__main__":
    main()
