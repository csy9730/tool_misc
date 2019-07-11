sudo apt-get install git

git clone https://github.com/Microsoft/ELL.git
sudo apt-get -y update

sudo apt-get install -y gcc cmake

apt-cache show llvm-dev
sudo apt-get install -y wget
wget -O - http://apt.llvm.org/llvm-snapshot.gpg.key | sudo apt-key add -
sudo apt-add-repository "deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-3.9 main"
sudo apt-get -y update
sudo apt-get -y upgrade

sudo apt-get install -y llvm-3.9-dev

sudo apt-get install -y libedit-dev
sudo apt-get install zlibc zlib1g zlib1g-dev

wget http://prdownloads.sourceforge.net/swig/swig-3.0.12.tar.gz
tar zxvf swig-3.0.12.tar.gz && cd swig-3.0.12
./configure --without-pcre && make && sudo make install

# Create the environment
conda create -n py36 anaconda python=3
# Activate the environment
source activate py36

sudo apt-get install -y libopenblas-dev doxygen

cd /home/csy/ell-master
mkdir build
cd build
cmake ..
make
make _ELL_python 
make doc