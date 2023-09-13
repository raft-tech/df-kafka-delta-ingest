FROM rust:1.69 AS builder
ARG CARGO_REGISTRIES_CRATES_IO_PROTOCOL=sparse

WORKDIR /build

COPY ./ .

RUN cargo build --release

FROM ubuntu

RUN apt-get update
RUN apt-get install -y ca-certificates

WORKDIR /build

COPY --from=builder /build/target/release/kafka-delta-ingest ./
ENTRYPOINT ["/build/kafka-delta-ingest"]