#!/bin/bash
#
#    Script to mount/unmount a remote filesystem
#
usage() {
    echo "Usage: $0 -d <path> [-s <path>] [-n <string>] [-u]                   "
    echo "  -d dst: mounting destination on local machine (~/mnt/gpu)          "
    echo "  -s src: path to remote src directory (gpu:/space/kidney/jleffell) "
    echo "  -n name: name of the local mount (gpu.csl.sri.com)                 "
    echo "  -u: unmount flag (default mode is to mount when -u not provided)   "
    1>&2; exit 1; }
# 1>&2 says to pass stdout to stderr?

while getopts ":s:d:n:uh" o; do
    case "${o}" in
        s)
            s=${OPTARG}
            # ((s == 45 || s == 90)) || usage
            ;;
        d)
            if [ -d ${OPTARG} ]; then
                d=${OPTARG}
            else
                echo "Destination directory does not exist, ${d}"
                usage
            fi
            ;;
        n)
            n=${OPTARG}
            ;;
        u)
            unmount=true
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

# Pull in default values for src and name
if [ -z "${s}" ]; then
    s=gpu:/space/kidney/jleffell
fi

if [ -z "${n}" ]; then
    n=gpu.csl.sri.com
fi

# Exit if no dst is provided
if [ -z "${d}" ]; then
    usage
fi

# if [ -z "${s}" ] || [ -z "${d}" ] || [ -z "${n}" ]; then
#     usage
# fi

# echo "src = ${s}"
# echo "dst = ${d}"
# echo "name = ${n}"

if [ ${unmount} ]; then
    echo "We are unmounting the sshfs ${n} at ${d} from ${s}"
    umount -f "${d}"
else
    echo "We are mounting an sshfs ${n} at ${d} from ${s}"
    sshfs "${s}" "${d}" -o volname="${n}"
fi
