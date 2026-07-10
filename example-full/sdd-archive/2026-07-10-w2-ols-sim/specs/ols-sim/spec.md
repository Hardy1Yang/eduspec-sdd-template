# ols-sim — w2 OLS 互動模擬

Teaching intent (教學意圖, per teaching-dna): the interactive MUST break the misconception that the fitted line is "the line through the most points" or "the line minimizing absolute error", and build the intuition "OLS = the line minimizing mean squared error (MSE)". The aha moment: students adjust slope/intercept trying to beat the OLS MSE and discover they never can. The screen MUST close the loop with one fixed takeaway sentence ("你應該注意到…").

## ADDED Requirements

### Requirement: Scatter plot with built-in Taiwan-context dataset

The page SHALL render a scatter plot of a hardcoded dataset (8 points, 手搖飲店「當日最高溫 x (°C) vs 日銷量 y (杯)」) on a canvas with labeled axes in Traditional Chinese. The page SHALL be a single offline HTML file with no external network requests (no CDN scripts, no external fonts, no fetch to third parties by default).

#### Scenario: Open the file offline

- **WHEN** the teacher opens sim-ols.html from the local filesystem with no internet connection
- **THEN** the scatter plot, sliders, MSE display and buttons all render and work with no errors in the console

### Requirement: Adjustable line with live MSE

The page SHALL provide two sliders (斜率 slope, 截距 intercept) that move a candidate line over the scatter plot in real time, and SHALL display the current line's MSE = (1/n)·Σ(yᵢ − (a + b·xᵢ))², recomputed on every slider input. The page SHALL also display the residual segments from each point to the current line so students can see errors shrink or grow.

#### Scenario: Student drags a slider

- **WHEN** the student moves the slope or intercept slider
- **THEN** the line, the residual segments, and the displayed MSE update immediately and consistently with the formula above

### Requirement: One-click OLS with correct math

The page SHALL provide a「一鍵 OLS」button that sets the line to the OLS solution computed from the hardcoded data as b = Σ(xᵢ−x̄)(yᵢ−ȳ)/Σ(xᵢ−x̄)² and a = ȳ − b·x̄, and SHALL display the OLS MSE as the benchmark to beat. The page SHALL show the fixed takeaway sentence:「你應該注意到：不管怎麼調，你的 MSE 都不會低於 OLS 的 MSE——OLS 就是這場比賽的必勝解。」

#### Scenario: Student clicks 一鍵 OLS

- **WHEN** the student clicks the「一鍵 OLS」button
- **THEN** the line jumps to the OLS solution and the displayed MSE equals the minimum MSE (within rounding)

##### Example: hardcoded dataset OLS solution

- **GIVEN** x = (22, 24, 26, 27, 29, 31, 33, 35), y = (180, 200, 240, 250, 300, 330, 360, 400)
- **WHEN** OLS is computed
- **THEN** slope ≈ 17.3905, intercept ≈ −210.9562, minimum MSE ≈ 30.94 (2 decimal places)

### Requirement: Interaction logging with offline fallback

The page SHALL append every meaningful interaction (slider release, OLS click, best-so-far MSE) to browser localStorage under a stable key, SHALL let the user export the log as a CSV file, and SHALL identify the user only by a self-chosen 代號 (nickname), never personal data. The page SHALL provide an optional token field reserved for a future shared mode; WHEN the token field is empty the page MUST operate fully offline and MUST NOT raise or display any error.

#### Scenario: No token provided

- **WHEN** the student uses the page without entering any token
- **THEN** interactions are still recorded to localStorage, CSV export works, and no error message appears

### Requirement: Projection-friendly Traditional Chinese UI

All labels, buttons and messages SHALL be in Traditional Chinese (Taiwan usage) with large font sizes suitable for classroom projection, and the page SHALL include the disclosure line「本互動由 AI 協助生成，經授課教師審核。」.

#### Scenario: Classroom projection

- **WHEN** the page is projected in class
- **THEN** axis labels, MSE readout and the takeaway sentence are readable (MSE readout and takeaway rendered at least ~24px equivalent)
