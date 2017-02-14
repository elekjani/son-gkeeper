FROM ruby:2.2.3-slim
RUN apt-get update && \
  apt-get install -y --no-install-recommends build-essential libcurl3 libcurl3-gnutls libcurl4-openssl-dev && \
	rm -rf /var/lib/apt/lists/*
RUN mkdir -p /app
WORKDIR /app
COPY Gemfile /app
RUN bundle install
COPY . /app
WORKDIR /app
ENV PORT 80
ENV PACKAGE_MANAGEMENT_URL http://son-gtkpkg
ENV SERVICE_MANAGEMENT_URL http://son-gtksrv
ENV FUNCTION_MANAGEMENT_URL http://son-gtkfnct
ENV VIM_MANAGEMENT_URL http://son-gtkvim
ENV RECORD_MANAGEMENT_URL http://son-gtkrec
ENV LICENCE_MANAGEMENT_URL http://son-gtklic
ENV KPI_MANAGEMENT_URL http://son-gtkkpi
CMD ["foreman", "start"]
