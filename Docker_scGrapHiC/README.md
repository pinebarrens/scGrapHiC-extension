# scGrapHiC TUI Docker

Interactive Docker image for the scGrapHiC Textual TUI (`tui/`).

## Files

| File | Purpose |
|------|---------|
| `Dockerfile` | Image definition (micromamba env `scgraphic`, Python 3.9, pip deps) |
| `environment.yml` | Base conda environment |
| `entrypoint.sh` | Launches `python tui/tui.py` |
| `.dockerignore` | Excludes large/generated paths from the build context |

## Build

Run from the **repository root** (parent of `Docker_scGrapHiC`):

```bash
docker build \
  -f Docker_scGrapHiC/Dockerfile \
  --ignorefile Docker_scGrapHiC/.dockerignore \
  -t scgraphic-tui .
```

If your Docker version does not support `--ignorefile`, copy the ignore file first:

```bash
cp Docker_scGrapHiC/.dockerignore .dockerignore
docker build -f Docker_scGrapHiC/Dockerfile -t scgraphic-tui .
```

## Run

The TUI requires an interactive terminal (`-it`):

```bash
docker run --rm -it \
  -v "$PWD/TUI_data:/data" \
  -v "$PWD/TUI_results:/results" \
  scgraphic-tui
```

Use `/data` and `/results` (and other mounted paths) when entering paths in the TUI.

### GPU (optional)

```bash
docker run --rm -it --gpus all \
  -v "$PWD/TUI_data:/data" \
  -v "$PWD/TUI_results:/results" \
  -v "$PWD/weights:/weights" \
  scgraphic-tui
```

## Notes

- The TUI runs pipeline steps via `conda run -n scgraphic python ...`. The image symlinks `conda` to `micromamba` and sets `SCGRAPHIC_CONDA_ENV=scgraphic`.
- `textual` and `rich` are installed explicitly because they are not listed in `requirements.txt`.
- Mount data, checkpoints, and output directories at runtime rather than baking them into the image.
