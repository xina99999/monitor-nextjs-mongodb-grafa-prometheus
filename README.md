# Next.js Monitoring System with Prometheus, Grafana, and MongoDB Cluster

## 📖 Overview

This project sets up a full monitoring stack for a **Next.js** application by integrating:
- **Prometheus** for collecting application and server metrics.
- **Grafana** for visualizing metrics and setting up alerting.
- **MongoDB Cluster** for storing application data with high availability.

The goal is to monitor application performance (response times, throughput, error rates) and ensure database reliability at scale.

---

## 🛠 Tech Stack

- **Next.js** — Frontend and Server-Side Rendering Application
- **Prometheus** — Time Series Metrics Collection
- **Grafana** — Data Visualization and Monitoring Dashboards
- **MongoDB Cluster** — Distributed Database System
- **Node.js** — Backend APIs
- **Docker Compose** — Container Orchestration (optional)

---

## 📦 Project Structure

```
/nextjs-app          # Next.js application code
/prometheus/         # Prometheus configuration (prometheus.yml)
/grafana/            # Grafana provisioning dashboards and data sources
/docker-compose.yml  # (Optional) Docker setup for services
README.md
```

---

## ⚙️ Setup Instructions

### 1. Clone the Repository
```bash
git clone  https://github.com/xina99999/monitor-nextjs-mongodb-grafa-prometheus.git
cd nextjs-monitoring
```

### 2. Start MongoDB Cluster
Set up a **MongoDB Atlas** cluster or a **self-hosted replica set**.
> Update your database URI in your Next.js environment:
```env
MONGODB_URI=mongodb+srv://username:password@cluster.mongodb.net/dbname
```

### 3. Configure Prometheus
Edit `prometheus/prometheus.yml`:
```yaml
scrape_configs:
  - job_name: 'nextjs-app'
    static_configs:
      - targets: ['nextjs-app:3000']
```

### 4. Start Prometheus & Grafana
You can use Docker Compose to start everything:
```bash
docker-compose up -d
```

Or start each service manually:
```bash
docker run -p 9090:9090 prom/prometheus --config.file=/path/to/prometheus.yml
docker run -p 4000:3000 grafana/grafana
```

Grafana default login:
- **Username:** admin
- **Password:** secret

Connect Grafana to Prometheus (http://localhost:9090) as a data source.

### 5. Expose Next.js Metrics
In your Next.js app, you can expose a `/metrics` endpoint:
```javascript
import client from 'prom-client';

const collectDefaultMetrics = client.collectDefaultMetrics;
collectDefaultMetrics();

export default async function handler(req, res) {
  res.setHeader('Content-Type', client.register.contentType);
  res.end(await client.register.metrics());
}
```

Add it to `/pages/api/metrics.js` route.

---

## 📊 Dashboards and Metrics

- **API Response Time**
- **Request Rate**
- **Error Rate**
- **Database Connection Health**
- **Custom Business Metrics**

You can import ready-to-use dashboards into Grafana from JSON files located inside `/grafana/dashboards`.

---

## 🚨 Alerting

Set up alert rules in Prometheus or Grafana:
- High response times
- Too many errors (5xx rate > threshold)
- MongoDB connection issues

Alerts can be integrated with:
- Slack
- Email
- PagerDuty
- Webhooks

---

## 📈 Future Improvements

- Load Balancer Metrics
- MongoDB Advanced Metrics (using `mongodb_exporter`)
- Auto-scaling Grafana and Prometheus
- Deploy on Kubernetes Cluster

---

## 👋 License

This project is licensed under the [MIT License](LICENSE).

---

## 👌 Contribution

Feel free to submit issues, fork the repo, and send PRs!  
Let's build a more resilient monitoring system together 🚀

