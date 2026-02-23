common_dir=$(realpath $(dirname ${BASH_SOURCE[0]})/common)

task=$1
if [ -z "$task" ]; then
    echo "task directory required" >&2
    exit 1
fi

if ! [ -d "$task" ]; then
    echo "task directory does not exist: ${task}" >&2
    exit 1
fi

if [ -f "$task"/env.sh ]; then
    source "$task"/env.sh
fi

if ! [ -f "$task"/run.sh ]; then
    echo "missing script: ${task}/run.sh"
    exit 1
fi

source ${common_dir}/functions.sh
source "$task"/run.sh

task_func=(
    pre
    run
    post
)

for x in "${task_func[@]}"; do
    step="${task}::${x}()"
    echo
    echo "[$step] Executing"
    ${x}
    retval=$?
    if (( $retval )); then
        echo "[$step] Failed (returned $retval)" >&2
        exit 1
    fi
    echo
done
echo "Done!"
