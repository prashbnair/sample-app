FROM registry.access.redhat.com/ubi8/python-38:latest

# Upgrade dependency management itself.
RUN pip install --upgrade pip pipenv

# Copy the sources to the app root, see base image Dockerfile for more details.
WORKDIR /opt/app-root/src/

COPY ./src/ .

# Copy the locked env since this is a production build.
COPY ./Pipfile Pipfile
COPY ./Pipfile.lock Pipfile.lock
COPY ./entrypoint.sh entrypoint.sh

# Set the Pythonpath to the sources root.
ENV PYTHONPATH="/opt/app-root/"\
    PIPENV_HIDE_EMOJIS="true" \
    VIRTUAL_ENV="/opt/app-root/"

# Install application dependencies.
RUN pipenv install --deploy --ignore-pipfile

ENTRYPOINT [ "./entrypoint.sh" ]