# Start

```sh
git submodule update --init --recursive
# On Ubuntu , You should do this
apt install libyaml-dev
make -C skynet macosx
make -C skynetgo LUAINC=`pwd`/skynet/3rd/lua
make -C core LUAINC=`pwd`/skynet/3rd/lua ROOT=`pwd`
mkdir -p data/{account,player}
```

# Service
