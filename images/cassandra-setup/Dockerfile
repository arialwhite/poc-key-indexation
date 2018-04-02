FROM dschroe/cassandra-docker:latest
RUN echo 'deb http://httpredir.debian.org/debian jessie-backports main contrib non-free' > /etc/apt/sources.list.d/jessie-backports.list && \
    apt-get update && \
    apt-get install -y -t jessie-backports python-cassandra && \
    export CQLSH_NO_BUNDLED=true \
    echo "CQLSH_NO_BUNDLED=true" >> /etc/environment && \
    sed -i 's/start_rpc: false/start_rpc: true/' /etc/cassandra/cassandra.yaml

CMD /bin/bash -c "sleep 1 && echo ' -- Pausing to let system catch up ... -->' && /docker-entrypoint.sh cassandra -f"