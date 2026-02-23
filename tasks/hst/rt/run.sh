pre() {
    echo "I do things before running."
}

run() {
    echo "I run things."
    echo SOURCED_ENV_FILE=${SOURCED_ENV_FILE}
}

post() {
    echo "I do things after running."
}
