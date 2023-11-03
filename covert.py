#!/usr/bin/env python

target = []
deps = []
build_script = []
variables = []
array = []

target_num = 0
ignore_path = 5
build_section = 0
mvfs_section = 0
variables_section = 0
depobj = ""
j = 0

with open('cr_output', 'r') as crfile, open('deps', 'w') as depsfile:
    for line in crfile:
        line = line.strip()
        if line == "----------------------------":
            continue

        line_array = line.split()
        if line_array[0] == "Target":
            target.append(line_array[1])
            deps = target[target_num]
            variables = target[target_num]
            build_script = target[target_num]
            target_num += 1
        elif line_array[0] == "MVFS":
            build_section = 0
            variables_section = 0
            mvfs_section = 1
        elif line_array[0] == "Variables":
            build_section = 0
            variables_section = 1
            mvfs_section = 0
        elif line_array[0] == "Build":
            build_section = 1
            variables_section = 0
            mvfs_section = 0

        if mvfs_section == 1:
            deps_split = line.split('@@')
            deps1 = deps_split[0].split('/')
            ignore_path1 = ignore_path - 1
            depobj = "/".join(deps1[ignore_path1:])
            depobj = depobj.lstrip('/')
            array.append(f"Target is {target[target_num - 1]} {depobj}\n")
            j += 1

    array1 = array[::-1]
    print(''.join(array1))
    depsfile.write(''.join(array1))
