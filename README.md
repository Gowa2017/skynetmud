# Start
```sh
git submodule update --init --recursive
make -C skynet macosx
make -C skynetgo LUAINC=`pwd`/skynet/3rd/lua
make -C core LUAINC=`pwd`/skynet/3rd/lua ROOT=`pwd`
```

# Service
