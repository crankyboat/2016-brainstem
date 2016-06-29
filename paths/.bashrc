# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export PATH=$PATH:$HOME/bin
unset SSH_ASKPASS

# Not sure
gnu_lib=/opt/lapack/gnu/lib
export BLAS=$gnu_lib/libblas.so
export LAPACK=$gnu_lib/liblapack.so
export LD_LIBRARY_PATH=$gnu_lib:$LD_LIBRARY_PATH

# User specific aliases and functions
alias brain='cd /oasis/projects/nsf/csd395/wel144/2016-brainstem'
alias notebook='jupyter notebook --config=/home/wel144/.jupyter/jupyter_notebook_config.py'
# alias notebook='jupyter notebook --config=/home/yuncong/.ipython/profile_parallel/ipython_notebook_config.py'

# Yuncong virtual environ
export PATH=/home/yuncong/screen-4.0.3/bin:$PATH
export PATH=/oasis/projects/nsf/csd181/yuncong/virtualenv-1.9.1/yuncongve/bin:$PATH
export LD_LIBRARY_PATH=/opt/python/lib:$LD_LIBRARY_PATH

# Brainstem
CSD181_YC=/oasis/projects/nsf/csd181/yuncong
CSD395_YC=/oasis/projects/nsf/csd395/yuncong
CSD395=/oasis/projects/nsf/csd395/wel144
export REPO_DIR=$CSD395_YC/Brain
export DATA_DIR=$CSD395_YC/CSHL_data_processed
export LABELING_DIR=$CSD395_YC/CSHL_data_labelings_losslessAlignCropped
export PIPELINE_SCRIPT_DIR=$CSD395_YC/Brain/pipeline

# source $CSD395_YC/setup2015.sh

# numpy and scipy compiled with MKL, so need to source this script
source $CSD395_YC/intel/bin/compilervars.sh -arch intel64 -platform linux

# For ndpitools programs, i.e. ndpi2tiff and ndpisplit
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CSD181_YC/hdf5-1.8.13/lib
export PATH=$PATH:$CSD395_YC/parallel-20150822-release/bin

# OpenCV
export OPENCV_DIR=/home/yuncong/csd181/opencv-2.4.9
export OPENCV_LIBDIR=$OPENCV_DIR/release/lib/python2.7/site-packages
export LD_LIBRARY_PATH=$OPENCV_DIR/release/lib:$LD_LIBRARY_PATH
export PYTHONPATH=$OPENCV_LIBDIR:$PYTHONPATH
export PKG_CONFIG_PATH=$OPENCV_DIR/release/lib/pkgconfig/:$PKG_CONFIG_PATH

# Multi-node
alias sync_result='function _sr(){ cd $LOCAL_RESULT_DIR; rsync -azP --delete --include="*/" --include="0*/*$2*" --exclude="*" -m  yuncong@gordon.sdsc.edu:$GORDON_RESULT_DIR/$1 . ; cd - ;}; _sr'
alias extract_result='function _er(){ mkdir $3; find $LOCAL_RESULT_DIR/$1 -regex .*/.*$2.* -type f -print0 | xargs -0 cp -t $3; }; _er'
alias killall_gordon_python='for i in {31..38} {41..48}; do ssh -o ConnectTimeout=10  gcn-20-$i.sdsc.edu "pkill -9 python"; done'
alias apply_all_gcn='function _aag(){ for i in {31..38} {41..48}; do ssh gcn-20-$i.sdsc.edu $1; done; }; _aag'
