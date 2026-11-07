# Marketplace Ads Analytics

### End-to-End Advertising Analytics | Python · SQL · A/B Testing · Power BI

## Project Overview

Data analytics project focused on evaluating advertising performance in a marketplace environment.

The project covers data generation, exploratory data analysis, SQL-based performance metrics, A/B testing, and interactive BI dashboards.

**Tech Stack:** Python, Pandas, NumPy, PostgreSQL, SQL, Power BI, DAX.

## Dataset

The synthetic dataset includes:

| Metric | Value |
|---|---:|
| Advertising campaigns | 100 |
| Impressions | 200,000 |
| Clicks | 9,713 |
| Orders | 610 |
| Completed orders | 543 |
| A/B test participants | 20,000 |

## Advertising Performance Analysis

Calculated key advertising metrics including CTR, CPC, CVR and ROAS.

**Key results:**

- Overall CTR: **4.86%**
- Total advertising spend: **170,949.96 RUB**
- Completed-order revenue: **1,216,483.33 RUB**
- Overall ROAS: **7.12x**

Identified campaigns with above-median CTR and below-median ROAS for further performance investigation.

## SQL Analysis

Used PostgreSQL queries with:

- JOIN and GROUP BY
- Common Table Expressions (CTEs)
- Aggregation and filtering
- Campaign ranking by ROAS

## A/B Testing

Analyzed a synthetic experiment comparing control and treatment groups of 10,000 users each.

| Metric | Control | Treatment | P-value |
|---|---:|---:|---:|
| Users with an ad click | 33.84% | 37.22% | 0.00000059 |
| Users with a completed purchase | 2.55% | 2.78% | 0.312597 |

**Findings:**

- Click conversion increased by **3.38 percentage points** (statistically significant).
- Purchase conversion increased by **0.23 percentage points** (not statistically significant).

The observed increase in click engagement did not establish a statistically significant improvement in purchase conversion.

## Power BI Dashboard

Created a two-page interactive Power BI report:

**Page 1 — Advertising Performance**
- KPI cards for impressions, clicks, CTR, spend, revenue, and ROAS
- ROAS by product category
- Revenue and advertising spend comparison
- Daily advertising trends
- Campaign-level performance table

**Page 2 — A/B Test Results**
- Comparison of click and purchase conversion
- Treatment effects
- Statistical conclusions

The interactive report is available in the `dashboard/` folder.

## Project Structure

- `data/` — synthetic CSV datasets
- `notebooks/` — Python analysis and A/B testing
- `sql/` — PostgreSQL queries
- `dashboard/` — Power BI report (.pbix)
- `images/` — dashboard screenshots

## Limitations

This data is my  Educational Marketplace Analytics Project

The simulation simplifies advertising auctions, user behavior, conversion attribution, and experimental exposure. Results demonstrate analytics methodology rather than real-world marketplace outcomes.
