FROM linkinghack/dbg-tool:v1.2
RUN apt update && apt install openssh-client -y
