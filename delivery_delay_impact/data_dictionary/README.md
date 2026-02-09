# 📚 Data Dictionary

This project centers on an order-level fact table: `marts.fact_orders`.

## 🗂️ marts.fact_orders
| Column | Description |
| --- | --- |
| `order_id` | Order ID |
| `customer_id` | Customer ID |
| `customer_unique_id` | Unified customer ID |
| `customer_state` | Customer state/region |
| `customer_city` | Customer city |
| `order_status` | Order status |
| `purchase_ts` | Purchase timestamp |
| `approved_ts` | Approval timestamp |
| `delivered_carrier_ts` | Carrier handover timestamp |
| `delivered_customer_ts` | Delivered-to-customer timestamp |
| `estimated_delivery_ts` | Estimated delivery date |
| `item_count` | Number of order items |
| `product_count` | Number of products |
| `seller_count` | Number of sellers |
| `price_total` | Total item value |
| `freight_total` | Total freight value |
| `category_main` | Primary product category |
| `payment_value_total` | Total payment value |
| `installments_max` | Maximum installment count |
| `payment_type_main` | Main payment type |
| `review_score_avg` | Average review score |
| `review_score_max` | Maximum review score |
| `low_rating_cnt` | Number of low ratings (1-2) |
| `review_comment_len_max` | Maximum review comment length |
| `lead_time_days` | Purchase-to-delivery lead time (days) |
| `ship_time_days` | Approval-to-delivery lead time (days) |
| `promise_slip_days` | Actual minus estimated delivery days |
| `delayed_flag` | Delayed delivery flag |
| `on_time_flag` | On-time/early flag |
| `early_flag` | Early delivery flag |
| `failed_order_flag` | Canceled/unavailable order flag |

## 🧪 analytics.v_orders_base
| Column | Description |
| --- | --- |
| `low_rating_flag` | 1 if average review score is 2 or below |
| `purchase_month` | Purchase month (YYYY-MM-01) |

## 🧪 analytics.v_segment_base
| Column | Description |
| --- | --- |
| `price_band` | Price range band |
| `freight_band` | Freight cost range band |

## 🧮 analytics.segment_priority
| Column | Description |
| --- | --- |
| `orders_cnt` | Segment order count |
| `delayed_rate` | Delay rate |
| `low_rating_rate` | Low-rating rate |
| `low_rating_rate_delayed` | Low-rating rate for delayed orders |
| `low_rating_rate_on_time` | Low-rating rate for on-time orders |
| `low_rating_lift` | Difference in low-rating rate |
| `opportunity_score` | Improvement priority score |
