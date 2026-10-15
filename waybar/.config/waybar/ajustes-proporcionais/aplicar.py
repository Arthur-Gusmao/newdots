#!/usr/bin/env python3
"""Aplica os tamanhos no Havoc e Swindle; Mew usa a opção -f."""
import hashlib
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys
from datetime import datetime

stage = Path(__file__).resolve().parent
changes = json.loads((stage / "manifest.json").read_text())
pending = []
check_only = "--check" in sys.argv

for change in changes:
    target = Path(change["target"])
    prepared = (stage / change["prepared"]).read_bytes()
    current = target.read_bytes()
    if current == prepared:
        continue
    if hashlib.sha256(current).hexdigest() != change["original_sha256"]:
        sys.exit(f"Arquivo mudou desde a preparação: {target}. Nenhum ajuste foi aplicado.")
    if not check_only and not os.access(target, os.W_OK):
        sys.exit(f"Sem permissão de escrita: {target}. Nenhum ajuste foi aplicado.")
    pending.append((target, prepared))

if check_only:
    print(f"Conteúdo validado: {len(pending)} configurações a atualizar, sem alterar o código do Mew.")
    sys.exit(0)

stamp = datetime.now().strftime("%Y%m%d-%H%M%S-%f")
backup = stage / ("backup-" + stamp)
backup.mkdir()
restore = []
for index, (target, prepared) in enumerate(pending):
    saved = backup / (str(index) + "-" + target.name)
    shutil.copy2(target, saved)
    restore.append({"target": str(target), "backup": str(saved)})

(backup / "restauracao.json").write_text(json.dumps(restore, indent=2) + "\n")

try:
    for target, prepared in pending:
        # Escreve no mesmo arquivo para acionar o watcher do Swindle.
        target.write_bytes(prepared)
except Exception:
    for item in reversed(restore):
        target = Path(item["target"])
        if item["backup"]:
            shutil.copy2(item["backup"], target)
        elif target.exists():
            target.unlink()
    raise

subprocess.run(["pkill", "-USR2", "-x", "waybar"], check=False)
print(f"Ajustes aplicados. Backups: {backup}")
print("Abra um novo Havoc e Mew. O Swindle deve recarregar a configuração automaticamente.")
