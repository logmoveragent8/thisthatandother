# AI Investment Analysis Prompt Library

Based on Compound with AI methodology, adapted for OpenClaw.

## Core Philosophy
- Use specialized prompts, not broad questions
- Chain prompts for comprehensive analysis
- Use DeepSearch-style models for research
- Structure outputs as investment memos

---

## Prompt 1: Industry Overview

**Purpose:** Understand any industry in 30 minutes

**When to use:** Before analyzing a company, understand the landscape

**Prompt:**
```
You are a senior sector analyst.

Your task is to help me fully understand how an industry works — not from a financial perspective, but from a strategic, structural, and operational lens.

GOAL
In this first phase, focus on the macro-structure and deep dynamics of the following industry: [INSERT INDUSTRY NAME].

COVER THESE POINTS

1. What is the current market size, and how is it expected to evolve (CAGR, 5–10 years)?
2. What are the main industry segments (by use case, tech, client type, etc.)?
3. Who are the typical players at each layer of the value chain?
4. Describe the full value chain from raw input to end user
5. What are the dominant long-term trends shaping the industry?
6. What are the historical disruptions or milestones that changed the landscape?

BEST PRACTICES
- Reflect deeply before writing
- Prioritize clarity, precision, and real-world applicability
- Use bullet points and headers
- If data is missing, suggest proxies or approximations
```

---

## Prompt 2: Company Deep Dive

**Purpose:** Comprehensive analysis of a specific company

**When to use:** Analyzing a potential investment

**Prompt:**
```
You are a senior equity research analyst with a value investing mindset.

TASK: Produce a comprehensive investment thesis for [TICKER: Company Name]

COVER THESE SECTIONS:

## 1. Business Overview
- What does the company do?
- Revenue breakdown by segment
- Key products/services

## 2. Market Opportunity
- Total Addressable Market (TAM)
- Serviceable Addressable Market (SAM)
- Growth drivers

## 3. Competitive Position
- Moat factors (network effects, switching costs, brand, cost advantages, regulatory)
- Key competitors and market share
- Competitive advantages/disadvantages

## 4. Management & Governance
- Leadership track record
- Capital allocation history
- Insider ownership

## 5. Financial Analysis
- 5-year revenue CAGR
- Gross margin trend
- Operating leverage
- Free cash flow generation
- Balance sheet strength

## 6. Valuation
- Current multiple (P/E, EV/EBITDA, etc.)
- Historical comparison
- Relative to sector

## 7. Risks
- Key risks (regulatory, competitive, execution)
- Bear case scenario

## 8. Catalysts
- What could drive the stock higher?
- Bull case scenario

## 9. Investment Thesis Summary
- One-paragraph bull case
- One-paragraph bear case
- Key numbers (market cap, P/E, revenue, growth)

BEST PRACTICES
- Cite specific data points
- Distinguish facts from opinions
- Be concise but thorough
```

---

## Prompt 3: Financial Health Check

**Purpose:** Quick financial due diligence

**When to use:** Initial screening or follow-up

**Prompt:**
```
Analyze the financial health of [TICKER: Company Name].

For each category, provide the metric, the value, and your assessment (Strong/Weak/Neutral):

## Profitability
- Gross margin: [X]% — [Assessment]
- Operating margin: [X]% — [Assessment]
- Net margin: [X]% — [Assessment]
- ROE: [X]% — [Assessment]
- ROIC: [X]% — [Assessment]

## Growth
- Revenue growth (TTM): [X]%
- Revenue growth (3yr CAGR): [X]%
- Earnings growth (3yr CAGR): [X]%

## Balance Sheet
- Debt/Equity: [X]
- Current ratio: [X]
- Interest coverage: [X]

## Cash Flow
- Free Cash Flow (TTM): $[X]M
- FCF Margin: [X]%
- Capital expenditure: $[X]M

## Valuation
- P/E (TTM): [X]x
- Forward P/E: [X]x
- EV/EBITDA: [X]x

FINAL ASSESSMENT: [Strong/Weak/Neutral] with 2-sentence summary
```

---

## Prompt 4: Management Assessment

**Purpose:** Evaluate leadership quality

**When to use:** Part of investment thesis

**Prompt:**
```
Research and assess the management team of [TICKER: Company Name].

COVER:

## CEO Profile
- Name, tenure, background
- Previous CEO roles (if any)
- Industry experience

## Leadership Track Record
- Total shareholder return during tenure
- Major capital allocation decisions (acquisitions, buybacks, dividends)
- Response to past challenges/crises

## Management Quality Indicators
- Transparency in communications
- Conservative vs aggressive accounting
- Employee satisfaction signals
- Customer satisfaction signals

## Insider Activity
- Insider ownership %: [X]%
- Recent buys/sells
- Options packages

## Governance Concerns
- Board independence
- Related party transactions
- Environmental/social governance issues

ASSESSMENT: Rate management as Excellent/Good/Average/Poor with reasoning
```

---

## Prompt 5: Risk Analysis

**Purpose:** Identify and quantify risks

**When to use:** Before finalizing investment decision

**Prompt:**
```
Conduct a comprehensive risk analysis for [TICKER: Company Name].

CATEGORIZE RISKS:

## Systematic Risks (cannot diversify away)
- Interest rate sensitivity
- Recession risk
- Regulatory risk
- Currency risk

## Industry Risks
- Commodity price exposure
- Technology disruption
- Changing customer preferences
- Supply chain dependencies

## Company-Specific Risks
- Key person dependence
- Customer concentration
- Patent expiry
- Legal/Litigation
- Debt load

## Risk Quantification
For each major risk, estimate:
- Probability (Low/Medium/High)
- Impact if occurs (Low/Medium/High)
- Time horizon (Near-term/Medium-term/Long-term)

## Risk Summary
- Top 3 risks ranked by (Probability × Impact)
- Mitigation factors in place
```

---

## Prompt 6: Tech Sector Deep Dive

**Purpose:** Specialized analysis for tech companies

**Prompt:**
```
You are a senior technology sector analyst.

Analyze [TICKER: Company Name] with focus on:

## Product & Technology
- Core technology/algorithm
- R&D spend as % of revenue
- Key patents/intellectual property
- Technology moat assessment

## Product-Market Fit
- Product-led growth indicators
- Net Revenue Retention (NRR): [X]%
- Customer acquisition cost (CAC): $[X]
- Customer lifetime value (LTV): $[X]
- LTV/CAC ratio: [X]

## Network Effects
- Direct network effects present? [Yes/No]
- Indirect network effects? [Yes/No]
- How does value increase with users?

## Platform Dynamics
- Platform vs integrated business model
- Take rate / platform fees
- Developer ecosystem health

## Competition in Tech
- Barriers to entry
- Switching costs for customers
- Incumbent response risk

## Scalability
- Gross margin expansion potential
- Marginal cost structure
- Regional expansion capability

## Key Tech Metrics (as applicable)
- Monthly Active Users (MAU): [X]
- Daily Active Users (DAU): [X]
- DAU/MAU ratio: [X]%
- Churn rate: [X]%
- Average revenue per user (ARPU): $[X]
```

---

## Prompt 7: Energy Sector Deep Dive

**Purpose:** Specialized analysis for energy companies

**Prompt:**
```
You are a senior energy sector analyst.

Analyze [TICKER: Company Name] with focus on:

## Asset Base
- Production profile (oil/gas/renewables mix)
- Reserve life index: [X] years
- Asset quality assessment
- Geographic diversification

## Cost Structure
- All-in cost of production: $[X]/barrel equivalent
- Break-even price: $[X]
- Operating leverage (sensitivity to commodity prices)
- Historical cost reduction track record

## commodity Price Exposure
- Oil price sensitivity: $[X] per $1 change in Brent
- Natural gas price sensitivity
- Hedging strategy

## Transition Risks
- ESG/Climate risk exposure
- Capital allocation to transition
- Renewable energy investments

## Regulatory
- Permitting status
- Tax incentives/credits
- Environmental compliance costs

## Energy-Specific Metrics
- Production (boepd): [X]
- Proved reserves (MMboe): [X]
- Reserve replacement ratio: [X]%
- Debt-adjusted cash flow yield: [X]%
```

---

## Prompt 8: AI Sector Deep Dive

**Purpose:** Specialized analysis for AI companies

**Prompt:**
```
You are a senior AI/technology analyst.

Analyze [TICKER: Company Name] with focus on:

## AI Positioning
- Role in AI value chain (chip maker/infrastructure/applications)
- Proprietary AI capabilities vs commoditized
- Data moat assessment

## Business Model
- SaaS/Consumption/Hybrid
- Revenue recognition timing
- Recurring revenue %: [X]%

## Growth Drivers
- AI-specific tailwinds
- Expansion within existing customers
- New customer acquisition

## Unit Economics
- CAC: $[X]
- CAC Payback period: [X] months
- Gross margin: [X]%
- Net Revenue Retention: [X]%

## Competitive Landscape
- Incumbent threat
- Open source competition
- Vertical integration risk

## AI-Specific Risks
- Model commoditization risk
- Key talent dependency
- Compute cost inflation

## Forward Indicators
- Pipeline/bookings growth
- Customer win rates
- Product announcements
```

---

## Workflow: Complete Analysis Chain

### Phase 1: Industry (15 min)
1. Run **Industry Overview** prompt

### Phase 2: Company (30 min)
2. Run **Company Deep Dive** for target company
3. Run **Financial Health Check**
4. Run **Management Assessment**

### Phase 3: Risk (15 min)
5. Run **Risk Analysis**

### Phase 4: Synthesis (10 min)
6. Summarize into investment memo

### Sector-Specific:
- Tech → Add **Tech Sector Deep Dive**
- Energy → Add **Energy Sector Deep Dive**
- AI → Add **AI Sector Deep Dive**

---

## Notes

- Use DeepSearch or long-context models for best results
- Always verify key numbers independently
- Chain prompts for comprehensive analysis
- Save outputs to memory for future reference
