# docker-compiler-explorer

[![Docker Build Compiler Explorer](https://github.com/StephanKa/docker-compiler-explorer/actions/workflows/build.yaml/badge.svg?branch=main)](https://github.com/StephanKa/docker-compiler-explorer/actions/workflows/build.yaml)

## Usage

```bash
git clone https://github.com/StephanKa/docker-compiler-explorer
cd docker-compiler-explorer
pip3 install -r requirements.txt
python3 scripts/generator.py
docker-compse up -d
```

## Compiler & Version

| Compiler | Version |
|----------|---------|
| Clang | 11<br/>12<br/>13<br/>14<br/>15 |
| Gcc | 9<br/>10<br/>11 |

## Libraries

| Library | Version |
|----------|---------|
| [ FMT ](https://github.com/fmtlib/fmt.git) | 8.1.1<br/>9.0.0<br/>9.1.0 |
| [ Boost SML ](https://github.com/boost-ext/sml.git) | 1.1.5<br/>1.1.6 |
| [ Catch2 ](https://github.com/catchorg/Catch2.git) | v2.13.9<br/>v3.1.0<br/>v3.2.0 |
| [ CTRE ](https://github.com/hanickadot/compile-time-regular-expressions.git) | v3.7.1 |
| [ expected_lite ](https://github.com/martinmoene/expected-lite.git) | v0.6.2 |
| [ googletest ](https://github.com/google/googletest.git) | v1.12.1 |
| [ hfsm2 ](https://github.com/andrew-gresyk/HFSM2.git) | 2.2.1 |
| [ nlohman JSON ](https://github.com/nlohmann/json.git) | v3.11.2 |
| [ spdlog ](https://github.com/gabime/spdlog.git) | 8.1.1<br/>9.0.0<br/>9.1.0 |

## To-Do
