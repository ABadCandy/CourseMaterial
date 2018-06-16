echo "One script installation for deep learning with CUDA8.0,CUDNNv6.0,caffe,keras,tensorflow."
echo "Written by Hao Tang."
echo "Ubuntu16.04 has python2.7 and python3.5 originally and default is python3,you can use 'alternative' to switch them.You can also use Anaconda or pyenv or vitualenv to manage different python environment."

# config
CAFFE_INSTALL=/opt

echo "1 of 5: Install cuda and cudnn"
# install nvidia driver and cuda(.deb or .run both include driver and cuda toolkit). In addition, you can also first download and install the Nvidia' driver(.run) and then install cuda toolkit(.run) without(no YES) self-contained driver. 
#sudo dpkg -i cuda-repo-ubuntu1604-8-0-local_8.0.44-1_amd64.deb
#sudo apt-get update
#sudo apt-get install -y cuda

# install cudnn6
#tar -xf cudnn-8.0-linux-x64-v6.0.tgz
#sudo cp cuda/include/* /usr/local/cuda/include/
#sudo cp -P cuda/lib64/* /usr/local/cuda/lib64/
#rm -rf cuda
#echo "export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:/usr/local/cuda/lib64" | sudo tee -a /etc/profile

# install pip and pyenv with python2.7 or Anaconda if you won't use default python2
#git clone git://github.com/yyuu/pyenv.git ~/.pyenv
#echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
#echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
#echo 'eval "$(pyenv init -)"' >> ~/.bashrc
#exec $SHELL -l

#source ~/.bashrc
#source /etc/profile

#pyenv install 2.7.14 -v
#pyenv rehash
#pyenv global 2.7.14

# install dependency with python
sudo apt-get install libc6-dev gcc g++
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm

#if python-dev cannot be installed, you can exec: 
#sudo apt-get install aptitude 
#sudo aptitude install python-dev  
#and press 'n'
sudo apt-get install -y python-dev  
sudo apt-get install -y python-pip  
sudo apt-get install -y python-nose  

# chmod for pip installation directories
#sudo chmod a+rw -R /usr/lib/python2.7
#sudo chmod a+rw -R /usr/local/bin
#sudo chmod a+rw -R /usr/local/share
#sudo chmod a+rw -R /usr/local/lib/python2.7

# upgrade pip
sudo -H python -m pip install --upgrade pip
#sudo cp /usr/bin/pip /usr/bin/pip.old
#sudo apt-get remove -y python-pip
#sudo mv /usr/bin/pip.old /usr/bin/pip


echo "2 of 5: Install opencv and others"
# install opencv
sudo apt-get install -y python-opencv libopencv*
# others
sudo apt-get install -y openssh-server vim python-tk iptux
sudo -H python -m pip install scikit-learn pinyin jupyter

echo "3 of 5: Install Tensorflow/Theano and Keras"
# install tf, keras
#pip install tensorflow_gpu-1.2.0rc2-cp27-cp27mu-manylinux1_x86_64.whl
sudo -H python -m pip install tensorflow-gpu==1.4.0
#pip install scipy-0.19.0-cp27-cp27mu-manylinux1_x86_64.whl
sudo -H python -m pip install scipy h5py keras==2.1.5 scikit-image
#pip install theano
# for visualization
sudo apt-get install -y graphviz
sudo -H python -m pip install --user pydot
sudo -H python -m pip install cython easydict nltk pygame
#echo "4 of 5: Install caffe"
sudo apt-get install -y gfortran
sudo apt-get install -y cmake
sudo apt-get install -y libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libhdf5-serial-dev
sudo apt-get install -y libboost-system-dev libboost-filesystem-dev libboost-thread-dev libboost-chrono-dev libboost-date-time-dev libboost-atomic-dev libboost-python-dev 
sudo apt-get install -y libgflags-dev libgoogle-glog-dev protobuf-compiler liblmdb-dev libopenblas-dev liblapack-dev libatlas-base-dev doxygen

#pyenv rehash
:'
tar -zxvf caffe_ubuntu1604_by_cmake.tar.gz
CAFFE_ROOT=$CAFFE_INSTALL/caffe
sudo mv caffe $CAFFE_INSTALL/
cd $CAFFE_ROOT
mkdir build
cd build
cmake ..
#make -j $(($(nproc) + 1))
make -j 4
make install

echo "export PYTHONPATH=$CAFFE_ROOT/build/install/python:\$PYTHONPATH" | sudo tee -a /etc/profile
'
source /etc/profile

#echo "5 of 5: Install pycharm"
# install pycharm
#tar -xf pycharm-community-2017.1.3.tar.gz
#rm -f ~/.local/share/applications/jetbrains-pycharm-ce.desktop
#sudo mv pycharm-community-2017.1.3 /opt/
#sudo ln -s -f /opt/pycharm-community-2017.1.3/bin/pycharm.sh /usr/bin/pycharm
# run pycharm
#pycharm

echo "Done."
