FROM debian:jessie

ADD exec.sh /exec.sh
RUN chmod +x /exec.sh
ADD example-monit.conf /tmp/example-monit.conf

CMD ["/exec.sh"]
