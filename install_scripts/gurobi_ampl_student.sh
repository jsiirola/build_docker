RUN echo "" && \
    echo "======================" && \
    echo "INSTALLING GUROBI_AMPL" && \
    echo "======================" && \
    echo ""
ARG TARGET="gurobi"
ENV PATH="${PREFIX}/Gurobi/bin:${PATH}"
ENV LD_LIBRARY_PATH="${PREFIX}/Gurobi/lib:${LD_LIBRARY_PATH}"
RUN cd ${PREFIX} && \
    rm -rf ${TARGET}.tgz && \
    wget -q "https://ampl.com/netlib/ampl/student/linux64/${TARGET}.tgz" && \
    mkdir -p Gurobi/bin && \
    mkdir -p Gurobi/lib && \
    tar -C Gurobi -xf ${TARGET}.tgz && \
    rm ${TARGET}.tgz && \
    mv Gurobi/*.so Gurobi/lib/ && \
    mv Gurobi/gurobi Gurobi/bin/gurobi_ampl && \
    chmod u+x Gurobi/bin/gurobi_ampl && \
    echo \#\!/bin/bash > Gurobi/bin/gurobi_cl && \
    chmod u+x Gurobi/bin/gurobi_cl && \
    echo GUROBI_AMPL_VERSION `Gurobi/bin/gurobi_ampl -v | grep -Po '\d+.\d+.\d+'` >> ${DYNAMIC_VARS_FILE}
ARG TARGET
