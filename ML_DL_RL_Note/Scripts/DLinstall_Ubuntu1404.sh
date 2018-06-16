echo "One script installation for deep learning with CUDA8.0,CUDNNv6.0,caffe,keras,tensorflow."
echo "Written by Hao Tang."
echo "Ubuntu16.04 default has python2.7 and python3.5,you can use 'alternative' to switch them.But this script use pyenv to install python2.7.14 and manage different python environment.  Certainly, you can also use Anaconda."

# config
CAFFE_INSTALL=/opt

echo "1 of 5: Install cuda and cudnn"
# install nvidia driver and cuda
#sudo dpkg -i cuda-repo-ubuntu1604-8-0-local_8.0.44-1_amd64.deb
#sudo apt-get update
#sudo apt-get install -y cuda

# install cudnn
#tar -xf cudnn-8.0-linux-x64-v6.0.tgz
#sudo cp cuda/include/* /usr/local/cuda/include/
#sudo cp cuda/lib64/* /usr/local/cuda/lib64/
#sudo ln -sf libcudnn.so.6.0.21 libcudnn.so.6 #注意修改版本号
#sudo ln -sf libcudnn.so.6 libcudnn.so
#sudo ldconfig
#rm -r -f cuda
#echo "export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:/usr/local/cuda/lib64" | sudo tee -a /etc/profile

# install pip and pyenv with python2.7
#git clone git://github.com/yyuu/pyenv.git ~/.pyenv
#echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
#echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
#echo 'eval "$(pyenv init -)"' >> ~/.bashrc
#exec $SHELL -l

#source ~/.bashrc

#pyenv install 2.7.14 -v
#pyenv rehash
#pyenv global 2.7.14

# install dependency with python
sudo apt-get install -y cmake
sudo apt-get install -y libc6-dev gcc g++
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
sudo pip install --upgrade pip
#sudo cp /usr/bin/pip /usr/bin/pip.old
#sudo apt-get remove -y python-pip
#sudo mv /usr/bin/pip.old /usr/bin/pip


echo "2 of 5: Install opencv and others"
# install opencv
sudo apt-get install -y python-opencv libopencv*
# others
sudo apt-get install -y openssh-server vim python-tk iptux
sudo pip install scikit-learn pinyin jupyter

echo "3 of 5: Install Tensorflow/Theano and Keras"
# install tf, keras
#pip install tensorflow_gpu-1.2.0rc2-cp27-cp27mu-manylinux1_x86_64.whl
#pip install tensorflow-gpu
#pip install scipy-0.19.0-cp27-cp27mu-manylinux1_x86_64.whl
sudo pip install scipy h5py keras scikit-image
#pip install theano
# for visualization
sudo apt-get install -y graphviz
sudo pip install pydot

#echo "4 of 5: Install caffe"
sudo apt-get install -y gfortran
sudo apt-get install -y cmake
sudo apt-get install -y libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libhdf5-serial-dev
sudo apt-get install -y libboost-system-dev libboost-filesystem-dev libboost-thread-dev libboost-chrono-dev libboost-date-time-dev libboost-atomic-dev libboost-python-dev 
sudo apt-get install -y libgflags-dev libgoogle-glog-dev protobuf-compiler liblmdb-dev libopenblas-dev liblapack-dev libatlas-base-dev doxygen

#pyenv rehash

tar -zxvf caffe_ubuntu1604_by_makefile.tar.gz
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

#echo "5 of 5: Install pycharm"
# install pycharm
#tar -xf pycharm-community-2017.1.3.tar.gz
#rm -f ~/.local/share/applications/jetbrains-pycharm-ce.desktop
#sudo mv pycharm-community-2017.1.3 /opt/
#sudo ln -s -f /opt/pycharm-community-2017.1.3/bin/pycharm.sh /usr/bin/pycharm
# run pycharm
#pycharm

echo "Done."
