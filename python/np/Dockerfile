FROM python
ADD server.py /server.py
ENV HTTP_PROXY http://16.0.96.20:3128  
ENV HTTPS_PROXY http://16.0.96.20:3128
RUN pip install Flask
EXPOSE 5000
CMD python server.py
