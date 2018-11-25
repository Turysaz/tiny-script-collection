echo 'Trying to install vallorics youcompleteme now.'
echo ''
echo 'Dependencies:'
echo '* cmake'
echo '* python'
echo '* clang (!)'
echo ''
echo 'Make shure all dependencies are installed.'
echo ''
echo 'YCM has to be compiled before installation. Supported'
echo 'languages are defined by build flags, which is done by'
echo 'this script. If you want some languages added or removed,'
echo 'please modify the build instructions in this script.'
echo ''
echo 'Are you ready for the installation?'
read -n1 -r -p " Press any key then.\n"

echo 'Start downloading YCM.'

git clone https://github.com/Valloric/YouCompleteMe.git
cd YouCompleteMe
git submodule update --init --recursive

python setup.py \
    --clang-completer \
    --system-libclang # required on arch for some reason...
    # --rust-completer # requires rust and cargo
    # --cs-completer   # requires mono


for dir in \
    autoload \
    ci \
    doc \
    plugin
do
    rsync -a $dir/ ~/.vim/$dir/
done


