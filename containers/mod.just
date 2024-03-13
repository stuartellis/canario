# SPDX-FileCopyrightText: 2024-present Stuart Ellis <stuart@stuartellis.name>
#
# SPDX-License-Identifier: MIT
#
# Recipes for container tasks

container_image_cpu := if arch() == 'aarch64' { 'arm64' } else { if arch() == 'x86_64' { 'amd64' } else { error('Unsupported operating system') } }
container_image_os := "linux"
container_tool := "docker"

# Build container image
[no-cd]
build image-id="runner":
    #!/usr/bin/env python3
    import subprocess
    import tomllib
    container_exe = "{{ container_tool }}"
    image_platform = "{{ container_image_os }}/{{ container_image_cpu }}"
    image_id = "{{ image-id }}"
    with open("pyproject.toml", mode="rb") as fp:
        config = tomllib.load(fp)
        image_base = config["tool"]["project"]["containers"][image_id]["base_image"]
        build_file = config["tool"]["project"]["containers"][image_id]["build_file"]
        project_name = config["tool"]["poetry"]["name"]
        app_name = config["tool"]["project"]["containers"][image_id]["app_name"]
        image_name = f"{project_name}-{image_id}"
        image_version = config["tool"]["poetry"]["version"]
        image_tag = f"{image_name}:{image_version}"
        poetry_version = config["tool"]["project"]["utilities"]["poetry"]
        args = [container_exe, "buildx", "build",
            "--platform", image_platform,
            "-f", build_file, "-t", image_tag,
            "--build-arg", f"BASE_IMAGE={image_base}",
            "--build-arg", f"APP_NAME={app_name}",
            "--build-arg", f"POETRY_VERSION={poetry_version}",
            "--label", f"org.opencontainers.image.version={image_version}",
            ".",]
        subprocess.run(args, check=True)

# Remove unused container images
[no-cd]
clean:
    @echo "Removing unused containers and images..."
    @{{ container_tool }} container prune -f
    @{{ container_tool }} image prune -f

# Check container build file with Trivy
[no-cd]
lint image-id="runner":
    #!/usr/bin/env python3
    import subprocess
    import tomllib
    image_id = "{{ image-id }}"
    trivy_cache_dir = "./tmp/trivy"
    with open("pyproject.toml", mode="rb") as fp:
        config = tomllib.load(fp)
        project_name = config["tool"]["poetry"]["name"]
        build_file = config["tool"]["project"]["containers"][image_id]["build_file"]
        args = ["trivy", "config",
            "--quiet",
            "--cache-dir", trivy_cache_dir,
            "--ignorefile", "./.trivyignore.yaml",
            build_file,
        ]
        subprocess.run(args, check=True)

# Run container image
[no-cd]
run image-id="runner":
    #!/usr/bin/env python3
    import os
    import subprocess
    import tomllib
    container_exe = "{{ container_tool }}"
    image_id = "{{ image-id }}"
    image_platform = "{{ container_image_os }}/{{ container_image_cpu }}"
    with open("pyproject.toml", mode="rb") as fp:
        config = tomllib.load(fp)
        project_name = config["tool"]["poetry"]["name"]
        image_name = f"{project_name}-{image_id}"
        image_version = config["tool"]["poetry"]["version"]
        image_tag = f"{image_name}:{image_version}"
        user_id = str(os.getuid())
        args = [container_exe, "run", "--rm",
            "--user", user_id,
            "--mount", "type=bind,source=.,destination=/opt/app",
            "-w", "/opt/app",
            image_tag,
        ]
        subprocess.run(args, check=True)

# Scan container image with Trivy
[no-cd]
scan image-id="runner":
    #!/usr/bin/env python3
    import os
    import subprocess
    import tomllib
    image_id = "{{ image-id }}"
    image_platform = "{{ container_image_os }}/{{ container_image_cpu }}"
    trivy_cache_dir = "./tmp/trivy"
    with open("pyproject.toml", mode="rb") as fp:
        config = tomllib.load(fp)
        project_name = config["tool"]["poetry"]["name"]
        image_name = f"{project_name}-{image_id}"
        image_version = config["tool"]["poetry"]["version"]
        image_tag = f"{image_name}:{image_version}"
        args = ["trivy", "image",
            "--cache-dir", trivy_cache_dir,
            "--compliance", "docker-cis",
            "--ignorefile", "./.trivyignore.yaml",
            "--quiet",
            image_tag,
        ]
        subprocess.run(args, check=True)

# Open shell in container image
[no-cd]
shell image-id="runner":
    #!/usr/bin/env python3
    import os
    import subprocess
    import tomllib
    container_exe = "{{ container_tool }}"
    image_id = "{{ image-id }}"
    image_platform = "{{ container_image_os }}/{{ container_image_cpu }}"
    with open("pyproject.toml", mode="rb") as fp:
        config = tomllib.load(fp)
        project_name = config["tool"]["poetry"]["name"]
        image_name = f"{project_name}-{image_id}"
        image_version = config["tool"]["poetry"]["version"]
        image_tag = f"{image_name}:{image_version}"
        user_id = str(os.getuid())
        args = [container_exe, "run", "--rm", "-it",
            "--user", user_id,
            "--mount", "type=bind,source=.,destination=/opt/app",
            "-w", "/opt/app",
            image_tag,
            "/bin/sh",
        ]
        subprocess.run(args, check=True)
