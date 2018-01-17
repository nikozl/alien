FROM python
ADD app.py /app.py
ADD templates /templates
ADD run.sh /run.sh
RUN pip install Flask
EXPOSE 5000
ENTRYPOINT [ "./run.sh" ] 
