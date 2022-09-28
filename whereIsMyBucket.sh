
if [[ $# -eq 0 ]] ; then
    echo "Usage: $0 profilePattern bucketName"
    exit 1
fi

profilePattern=$1
bucketName=$2

for i in $(aws configure list-profiles | grep "${profilePattern}"); do
  BUCKET=${bucketName};
  export AWS_PROFILE=${i}
  aws s3 ls | grep "${BUCKET}" && echo "${i}" ;
done