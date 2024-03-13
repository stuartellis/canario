

# Install Trivy
add-trivy:
    #!/usr/bin/env sh
    set -eu
    TEMP_DOWNLOAD_DIR="{{ downloads_dir }}/tmp/trivy"
    mkdir -p $TEMP_DOWNLOAD_DIR
    cd $TEMP_DOWNLOAD_DIR
    APP_DOWNLOAD_URL=https://github.com/aquasecurity/trivy/releases/download/v{{ trivy_version }}/trivy_{{ trivy_version }}_Linux-64bit.tar.gz
    curl -S -s -L $APP_DOWNLOAD_URL > trivy.tar.gz
    tar xzf trivy.tar.gz trivy
    mkdir -p "{{ executable_directory() }}"
    cp trivy "{{ executable_directory() }}"
    cd "{{ downloads_dir }}/tmp"
    rm -fr $TEMP_DOWNLOAD_DIR
