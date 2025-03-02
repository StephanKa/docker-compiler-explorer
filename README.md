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
| Clang | 13<br/>14<br/>15<br/>16<br/>17<br/>18<br/>19 |
| Gcc | 9<br/>10<br/>11<br/>12<br/>13<br/>14 |

## Libraries

| Library | Version | Type | Description |
|----------|---------|-----|-----|
| [ FMT ](https://github.com/fmtlib/fmt.git) | 8.1.1<br/>9.1.0<br/>10.1.1<br/>11.1.3 | static | A modern formatting library |
| [ Boost SML ](https://github.com/boost-ext/sml.git) | 1.1.11 | header-onldy | A modern state machine library |
| [ Catch2 ](https://github.com/catchorg/Catch2.git) | v2.13.9<br/>v3.8.0 | header-onldy | A modern unit test framework |
| [ CTRE ](https://github.com/hanickadot/compile-time-regular-expressions.git) | v3.9.0 | header-onldy | Compile-time regular expressions |
| [ expected_lite ](https://github.com/martinmoene/expected-lite.git) | v0.8.0 | header-onldy | expected_lite |
| [ googletest ](https://github.com/google/googletest.git) | v1.13.0<br/>v1.15.0 | header-onldy | Googletest unit test framework |
| [ hfsm2 ](https://github.com/andrew-gresyk/HFSM2.git) | 2.5.2 | header-onldy | Hierarchy Finite State Machine |
| [ nlohman JSON ](https://github.com/nlohmann/json.git) | v3.11.3 | header-onldy | Modern C++ JSON |
| [ spdlog ](https://github.com/gabime/spdlog.git) | v1.15.1 | header-onldy | Modern logger using fmt library |
| [ benchmark ](https://github.com/google/benchmark.git) | v1.9.1 | static | A library to benchmark code snippets, similar to unit tests. |
| [ cthash ](https://github.com/hanickadot/cthash.git) | main | header-onldy | This library is constexpr implementation of SHA-2, SHA-3, and xxhash family of hashes. |
| [ magicenum ](https://github.com/Neargye/magic_enum.git) | v0.9.3 | header-onldy | Header-only C++17 library provides static reflection for enums, work with any enum type without any macro or boilerplate code. |
| [ spy ](https://github.com/jfalcou/spy.git) | 1.0.0 | header-onldy | Detection and versioning of operating systems, compilers, architecture and other element are traditionally done using preprocessor macros. |
| [ expected ](https://github.com/TartanLlama/expected.git) | v1.1.0 | header-onldy | Single header implementation of std::expected with functional-style extensions. |

## Tools

| Name | Version |
|----------|---------|
| iwyu | 19 |
| cmake | 3.31.6 |

## To-Do