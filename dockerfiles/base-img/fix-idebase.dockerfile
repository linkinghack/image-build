FROM linkinghack/ide-base:full-230111

# Fire Docker/Moby script if needed along with Oryx's benv
ENTRYPOINT [ "/usr/local/share/docker-init.sh", "/usr/local/share/ssh-init.sh" ]
CMD [ "sleep", "infinity" ]
