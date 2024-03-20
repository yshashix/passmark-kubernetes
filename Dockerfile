FROM ubuntu:22.04

# Install required dependencies
RUN apt-get update && \
    #add-apt-repository universe && \
    apt-get install -y libncurses5 curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create a directory to store results
RUN mkdir /passmark

# Copy PassMark executable from local directory to the image
COPY pt_linux_x64 /passmark/pt_linux_x64

# Set the working directory
WORKDIR /passmark

RUN chmod +x /passmark/pt_linux_x64

# Run PassMark Test and output results to a file
ENTRYPOINT ["./pt_linux_x64" , "-r" , " 1"]