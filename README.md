# scGrapHiC-extension

[scGrapHiC](https://github.com/rsinghlab/scGrapHiC) is a deep learning framework that performs graph deconvolution to predict pseudobulk scHi-C contact maps for individual cell types from pseudobulk scRNA-seq and bulk Hi-C. The bulk Hi-C map provides a structural prior, while the scRNA-seq signal guides the recovery of chromatin interactions for each cell type. CTCF and CpG signals are incorporated as additional features related to chromatin organization.

This repository extends scGrapHiC with fine tuning, pretrained weights, an interactive terminal interface, and Docker support to facilitate application of the model to new datasets.

## Installation

### Docker

We recommend using Docker to run the interactive workflow. The image provides the Python 3.9 environment and required dependencies. Input data and model weights are stored outside the container and are mounted at run time.

```bash
git clone https://github.com/pinebarrens/scGrapHiC-extension.git
cd scGrapHiC-extension

docker build -f Docker_scGrapHiC/Dockerfile -t scgraphic-tui .
```

### Local installation

```bash
git clone https://github.com/pinebarrens/scGrapHiC-extension.git
cd scGrapHiC-extension

conda create -n scgraphic python=3.9
conda activate scgraphic
pip install -r requirements.txt
pip install textual rich

python tui/tui.py
```

## Usage

The TUI provides a conveninent way to run the workflow. It guides users through pseudobulk preparation, preprocessing, dataset construction, inference, fine-tuning, and analysis, and displays the output of each step within the interface.

Two workflows are supported:

```text
Blind prediction:   Pseudobulk → Parse RNA-seq → Build dataset → Inference → Analysis
Ground truth:       Pseudobulk → Parse RNA-seq → Parse scHi-C → Build dataset
                    → Inference → Fine-tune → Analysis
```

Fine-tuning requires paired scRNA-seq and scHi-C data so that predicted contact maps can be compared with ground truth during supervised weight adjustment. When ground-truth scHi-C is unavailable, the inference workflow can instead be used to generate pseudobulk scHi-C predictions from the RNA input.

## Data and model weights

The [original scGrapHiC repository](https://github.com/rsinghlab/scGrapHiC) provides the pretrained model weights and supporting reference files used by the model, including CTCF and CpG scores, gene annotations, chromosome sizes, and processed example datasets. These resources are available from the original [scGrapHiC data folder](https://drive.google.com/drive/folders/1Bo7sq2TlgVZRU6c6JB4MFAT2LZSz0SEm?usp=sharing).

This extension allows pretrained or fine-tuned checkpoints to be selected explicitly for inference. Fine-tuning can be performed on additional paired datasets using `finetune.py` or through the TUI.

## Citation

The scGrapHiC model was originally described in:

> Murtaza G, Butaney B, Wagner J, Singh R. scGrapHiC: deep learning-based graph deconvolution for Hi-C using single cell gene expression. *Bioinformatics*. 2024;40(Suppl 1):i490–i500. https://doi.org/10.1093/bioinformatics/btae223

If you use the workflow extensions in this repository, please also cite the accompanying Application Note once available.

## Issues

Please report bugs, problems, or feature requests through the [GitHub issue tracker](https://github.com/pinebarrens/scGrapHiC-extension/issues).
