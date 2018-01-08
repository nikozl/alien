FROM python
ENV HTTP_PROXY http://16.0.96.20:3128
ENV HTTPS_PROXY http://16.0.96.20:3128
ADD server.py /server.py
RUN pip install Flask
EXPOSE 5000
CMD python server.py
