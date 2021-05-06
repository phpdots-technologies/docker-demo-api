cd /var/www/
. ./.env
aws configure set aws_access_key_id ${AWS_ECS_ACCESS_KEY}
aws configure set aws_secret_access_key ${AWS_ECS_SECRET_ACCESS_KEY}

index=0
taskArn=$(aws ecs list-tasks --cluster ${CLUSTER_NAME} --started-by events-rule/${SCHEDULED_TASK_NAME} --query "taskArns[${index}]" --output text)
until [ "$taskArn" = "None" ]
do
  echo "aws ecs stop-task --cluster ${CLUSTER_NAME} --task $taskArn" 
  aws ecs stop-task --cluster ${CLUSTER_NAME} --task $taskArn
  taskArn=$(aws ecs list-tasks --cluster ${CLUSTER_NAME} --started-by events-rule/${SCHEDULED_TASK_NAME} --query "taskArns[${index}]" --output text)
done
