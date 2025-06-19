✅ What Is AWS CloudWatch?
AWS CloudWatch is a monitoring and observability service that helps you track:

Logs (e.g. from EC2, Lambda)

Metrics (e.g. CPU, memory)

Events (e.g. EC2 restart, deployment success)

Alarms (e.g. notify when CPU > 80%)

🧠 Why Use CloudWatch?

| Feature                     | Purpose                                              |
| --------------------------- | ---------------------------------------------------- |
| 📊 **Metrics**              | See how resources (EC2, RDS, Lambda) are performing  |
| 📄 **Logs**                 | Collect application/system logs                      |
| 🚨 **Alarms**               | Auto-trigger alerts or actions                       |
| 📅 **Events (EventBridge)** | Respond to AWS resource changes (like auto shutdown) |
| 🎯 **Dashboards**           | Visualize data on a single pane                      |

🧱 Core Components
1. CloudWatch Metrics
Built-in metrics: EC2 (CPU, Disk, Network), Lambda, RDS, etc.

Custom metrics: Your application can send data via SDKs

2. CloudWatch Logs
Collect and store logs from:

EC2 (via CloudWatch Agent)

Lambda

ECS containers

Application logs (Python, Java, Node.js etc.)

3. CloudWatch Alarms
Threshold-based alerting (e.g., CPU > 80% for 5 minutes)

Integrates with SNS (email, SMS)

Can trigger actions: Auto-scaling, stop/start EC2

4. CloudWatch Events (EventBridge)
Event-driven actions (e.g., run a Lambda on EC2 launch)

Used for automation & orchestration

5. CloudWatch Dashboards
Visual representation of metrics

Can combine multiple metrics into one dashboard
