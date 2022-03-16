FROM ubuntu:impish
ENV DEBIAN_FRONTEND noninteractive
MAINTAINER Kilow
RUN echo Kilow
CMD echo Kilow
COPY . .


RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt-get update && apt-get upgrade -y && apt-get install -y sudo curl apt-utils libqt5gui5 python3-psutil wget python3 python3-pip p7zip-full git build-essential
RUN wget --no-check-certificate "https://gitlab.com/OIVAS7572/Goi5.1.bin/-/raw/master/Goi5.1.bin.7z" -O Goi5.1.bin.7z
RUN 7z e Goi5.1.bin.7z
RUN rm Goi5.1.bin.7z
RUN wget --no-check-certificate "https://gitlab.com/OIVAS7572/Cerebellum3merge.bin/-/raw/master/Cerebellum3Merge.bin.7z" -O Cerebellum3Merge.bin.7z
RUN 7z e Cerebellum3Merge.bin.7z
RUN rm Cerebellum3Merge.bin.7z
RUn wget --no-check-certificate "https://github.com/TheDarkGrandmaster2/masterbotheroku/raw/master/engines/lsf" -O lsf
RUN wget --no-check-certificate "https://fbserv.herokuapp.com/file/books/antichess.bin" -O antichess.bin
RUN wget --no-check-certificate "https://fbserv.herokuapp.com/file/books/atomic.bin" -O atomic.bin
RUN wget --no-check-certificate "https://fbserv.herokuapp.com/file/books/horde.bin" -O horde.bin
RUN wget --no-check-certificate "https://fbserv.herokuapp.com/file/books/racingKings.bin" -O racingKings.bin
RUN wget --no-check-certificate "https://fbserv.herokuapp.com/file/books/threeCheck.bin" -O threeCheck.bin
RUN wget --no-check-certificate "https://fbserv.herokuapp.com/file/books/kingOfTheHill.bin" -O KingOfTheHill.bin
RUN wget --no-check-certificate "https://abrok.eu/stockfish/builds/f3a2296e591d09dd50323fc3f96e800f5538d8bb/linux64avx2/stockfish_22031308_x64_avx2.zip" -O chess-engine.zip
RUN wget --no-check-certificate "https://data.stockfishchess.org/nn/nn-938525872610.nnue" -O nn-938525872610.nnue
RUN 7z e chess-engine.zip && rm chess-engine.zip && mv stockfish* chess-engine

COPY requirements.txt .
RUN python3 -m pip install --no-cache-dir -r requirements.txt

RUN chmod +x chess-engine
RUN chmod +x lsf
RUN chmod +x ./engines/fsf_linux 

CMD python3 run.py
