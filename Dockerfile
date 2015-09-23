FROM centos:7

RUN yum -y update; yum clean all; yum -y install wget git ed libcurl-devel gcc-c++ pango-devel

WORKDIR /opt/
# Install R
RUN wget https://mran.revolutionanalytics.com/install/RRO-3.2.2.el7.x86_64.rpm; \
    yum install -y RRO-3.2.2.el7.x86_64.rpm; rm -rf RRO-3.2.2.el7.x86_64.rpm

RUN sed -i "4s/.*/R_HOME_DIR=\/usr\/lib64\/RRO-3.2.2\/R-3.2.2\/lib64\/R/g" /usr/lib64/RRO-3.2.2/R-3.2.2/lib64/R/bin/R

# Install necessary R packages
RUN R -e "install.packages(c('shiny', 'rmarkdown'), repos='https://cran.rstudio.com/')"
# Install Shiny Server
RUN wget https://download3.rstudio.org/centos5.9/x86_64/shiny-server-1.4.0.721-rh5-x86_64.rpm; \
	yum install -y --nogpgcheck shiny-server-1.4.0.721-rh5-x86_64.rpm; \
	rm -rf shiny-server-1.4.0.721-rh5-x86_64.rpm
# Install Radiant
RUN R -e "install.packages('radiant', repos='http://vnijs.github.io/radiant_miniCRAN/')"
RUN git clone --depth 1 https://github.com/warmdev/radiant-mod.git; \
	cp -r radiant-mod/inst/* /srv/shiny-server; cp -r radiant-mod/R /srv; \
	rm -rf radiant-mod;
# Add starting script
ADD shiny-server.sh /usr/bin/shiny-server.sh
RUN chmod +x /usr/bin/shiny-server.sh

EXPOSE 3838

CMD ["/usr/bin/shiny-server.sh"]