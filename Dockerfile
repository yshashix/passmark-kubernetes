FROM ubuntu:22.04

# Install required dependencies
RUN apt-get update && apt-get install -y \
    libncurses5 \
    curl \
    xvfb \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create a directory to store results and PassMark executable
RUN mkdir /passmark

# Set DISPLAY environment variable for Xvfb
ENV DISPLAY=:99

# Copy the PassMark executable and a script to run it from your local directory to the image
COPY pt_linux_x64  /passmark/
COPY run_passmark.sh /passmark/

# Give execution rights to the PassMark binary and the script
RUN chmod +x /passmark/pt_linux_x64 /passmark/run_passmark.sh

# Set the working directory
WORKDIR /passmark

# Use the script to start Xvfb and run the PassMark test
ENTRYPOINT ["./run_passmark.sh"]
