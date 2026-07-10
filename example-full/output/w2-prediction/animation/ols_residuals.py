"""w2 教學動畫：殘差如何縮小——直線轉向 OLS。

依 animation/spec.md 四幕製作；資料與 sim-ols.html 相同（教學用虛構數據）。
Render: python3 -m manim -ql ols_residuals.py OLSResiduals
"""
from manim import (
    Axes, Create, DecimalNumber, Dot, FadeIn, FadeOut, Line, Text, VGroup,
    ValueTracker, Write, LaggedStart, always_redraw, interpolate,
    DOWN, LEFT, RIGHT, UP, BLUE, ORANGE, RED, WHITE, Scene, rate_functions,
)

# 手搖飲資料：當日最高溫 x (°C) vs 日銷量 y (杯) —— 與 sim-ols.html 相同
DATA = [(22, 180), (24, 200), (26, 240), (27, 250),
        (29, 300), (31, 330), (33, 360), (35, 400)]

CJK_FONT = "PingFang TC"  # macOS 內建繁中字型


def ols(data):
    """b = Σ(xi−x̄)(yi−ȳ)/Σ(xi−x̄)² ; a = ȳ − b·x̄（與互動網頁同一公式）"""
    n = len(data)
    mx = sum(x for x, _ in data) / n
    my = sum(y for _, y in data) / n
    sxy = sum((x - mx) * (y - my) for x, y in data)
    sxx = sum((x - mx) ** 2 for x, _ in data)
    b = sxy / sxx
    return my - b * mx, b  # (intercept, slope)


def mse(data, a, b):
    return sum((y - (a + b * x)) ** 2 for x, y in data) / len(data)


A_OLS, B_OLS = ols(DATA)          # ≈ (−210.9562, 17.3905)
A0, B0 = 150.0, 5.0               # 明顯不準的起始直線
MSE_MIN = mse(DATA, A_OLS, B_OLS)  # ≈ 30.94


class OLSResiduals(Scene):
    def construct(self):
        # ── 第 1 幕：標題與散布圖 ──
        title = Text("殘差如何縮小：直線轉向 OLS", font=CJK_FONT, font_size=40)
        title.to_edge(UP)
        self.play(Write(title), run_time=1.5)

        axes = Axes(
            x_range=[20, 37, 5], y_range=[100, 460, 100],
            x_length=8.5, y_length=4.6,
            axis_config={"include_numbers": True, "font_size": 24},
        ).shift(DOWN * 0.6 + LEFT * 1.4)
        x_lab = Text("當日最高溫（°C）", font=CJK_FONT, font_size=26)
        x_lab.next_to(axes.x_axis, DOWN, buff=0.3)
        y_lab = Text("日銷量（杯）", font=CJK_FONT, font_size=26)
        y_lab.rotate(90 * 3.14159265 / 180).next_to(axes.y_axis, LEFT, buff=0.25)
        self.play(Create(axes), FadeIn(x_lab), FadeIn(y_lab), run_time=1.5)

        dots = VGroup(*[Dot(axes.c2p(x, y), radius=0.07, color=WHITE) for x, y in DATA])
        self.play(LaggedStart(*[FadeIn(d, scale=2) for d in dots], lag_ratio=0.12), run_time=1.5)
        self.wait(0.5)

        # ── 第 2 幕：起始直線、殘差、MSE ──
        t = ValueTracker(0.0)  # 0 = 起始線, 1 = OLS 線

        def a_of_t():
            return interpolate(A0, A_OLS, t.get_value())

        def b_of_t():
            return interpolate(B0, B_OLS, t.get_value())

        def make_line():
            a, b = a_of_t(), b_of_t()
            return Line(axes.c2p(20, a + b * 20), axes.c2p(37, a + b * 37),
                        color=BLUE, stroke_width=6)

        def make_residuals():
            a, b = a_of_t(), b_of_t()
            return VGroup(*[
                Line(axes.c2p(x, y), axes.c2p(x, a + b * x), color=ORANGE, stroke_width=5)
                for x, y in DATA
            ])

        line = always_redraw(make_line)
        residuals = always_redraw(make_residuals)

        mse_num = DecimalNumber(mse(DATA, A0, B0), num_decimal_places=2, font_size=44)
        mse_num.add_updater(lambda m: m.set_value(mse(DATA, a_of_t(), b_of_t())))
        mse_txt = Text("MSE＝", font=CJK_FONT, font_size=36, color=ORANGE)
        mse_group = VGroup(mse_txt, mse_num).arrange(RIGHT, buff=0.15)
        mse_group.to_edge(RIGHT, buff=0.4).shift(UP * 1.6)
        mse_num.add_updater(lambda m: m.next_to(mse_txt, RIGHT, buff=0.15))

        self.play(Create(line), run_time=1.2)
        static_res = make_residuals()  # 先用靜態殘差做進場動畫
        self.play(LaggedStart(*[Create(r) for r in static_res], lag_ratio=0.1), run_time=1.8)
        self.remove(*static_res)       # 移除靜態版，換成會跟著直線更新的版本
        self.add(residuals)
        self.play(FadeIn(mse_group), run_time=0.8)
        self.wait(0.7)

        # ── 第 3 幕：直線轉向 OLS，殘差縮短、MSE 下降 ──
        note = Text("直線越靠近 OLS，殘差越短、MSE 越小",
                    font=CJK_FONT, font_size=30, color=ORANGE)
        note.next_to(title, DOWN, buff=0.25)
        self.play(FadeIn(note), run_time=0.8)
        self.play(t.animate.set_value(1.0), run_time=7,
                  rate_func=rate_functions.ease_in_out_sine)
        self.wait(1.0)

        # ── 第 4 幕：金句收束 ──
        punch = Text("OLS＝讓 MSE 最小的那條線", font=CJK_FONT, font_size=44, color=RED)
        punch.next_to(axes, UP, buff=0.1).shift(RIGHT * 1.0)
        self.play(FadeOut(note), Write(punch), run_time=1.8)
        self.wait(2.5)
