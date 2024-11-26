project('neotest-cpp-meson-example',
  'cpp',
  version: '0.1.0',
  default_options: ['cpp_std=c++17'])

catch2_proj = subproject('catch2')
catch2_with_main_dep = catch2_proj.get_variable('catch2_with_main_dep')

subdir('src/catch2')
