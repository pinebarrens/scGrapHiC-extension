#!/usr/bin/env bash
set -euo pipefail

cd /opt/scGrapHiC
exec micromamba run -n scgraphic python tui/tui.py
