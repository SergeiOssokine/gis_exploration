import argparse

import numpy as np
import vedo
from scipy.spatial.transform import Rotation as R

shape_axis = {
    "normal": np.array([0.0, 0.0, 1.0]),
    "transverse": np.array([0.0, 1.0, 0.0]),
    "oblique": np.array([0.0, 1 / np.sqrt(2), 1 / np.sqrt(2)]),
}


p = argparse.ArgumentParser()
p.add_argument(
    "--orientation-type",
    type=str,
    help="Type of orientation. Can be one of 'normal','transverse','oblique'",
    default="normal",
)
p.add_argument(
    "--projection-type",
    type=str,
    help="Type of projection. Can be one of 'azimuthal','cylindrical','conical'",
    default="cylindrical",
)
args = p.parse_args()

plt = vedo.Plotter(interactive=False)

# Make the Earth
E = vedo.Earth()

normal = np.array([0.0, 0.0, 1.0])
chosen_axis = shape_axis[args.orientation_type]
ax = np.cross(normal, chosen_axis)
nrm = np.linalg.norm(ax)

# The rotation to rotate the starting normal to align with the
# chosen axis
if nrm > 1e-8:
    dtprd = np.dot(normal, chosen_axis)
    theta = np.arccos(dtprd)
    axis = ax / nrm
    rot = R.from_rotvec(axis * theta)
else:
    theta = 0.0
    axis = np.array([0.0, 0.0, 1.0])
    rot = R.from_rotvec(np.array([0.0, 0.0, 0.0]))

# Note that everything starts being oriented in the "normal" way, i.e. axis of symmetry along z
# and is then rotated as needed

if args.projection_type == "cylindrical":
    sh = vedo.Cylinder(res=72, alpha=0.4, r=1.01, cap=False).c("gray")
    sh = sh.rotate(np.rad2deg(theta), axis=axis)
    # 1.01 is just so that the lines show up on top of the sphere
    pts1 = np.array(
        [
            (1.01 * np.sin(x), 1.01 * np.cos(x), 0.0)
            for x in np.arange(0, 2 * np.pi, 0.01)
        ]
    )
elif args.projection_type == "azimuthal":
    pt = shape_axis[args.orientation_type]
    sh = vedo.Plane(pos=pt, normal=pt, s=(2, 2), res=(10, 10), c="gray", alpha=0.4)
    pts1 = None
elif args.projection_type == "conical":
    # The latitude at which the cone touches the sphere
    lat = np.pi / 6
    r = 1.01
    h_s = r / np.sin(lat)
    h = h_s + r
    # Shift the center of the cone to where it belongs
    pos = normal * h / 2 - np.array([0.0, 0.0, r])
    b_r = h * np.tan(lat)
    sh = vedo.Cone(res=72, r=b_r, pos=pos, height=h, alpha=0.4).c("gray")
    # Roate the cone to the right orientation, i.e. so that the axis of symmetry is along
    # the chosen axis
    sh = sh.rotate(np.rad2deg(theta), axis=axis)
    r_c = r * np.cos(lat)
    pts1 = np.array(
        [
            (r_c * np.sin(x), r_c * np.cos(x), r * np.sin(lat))
            for x in np.arange(0, 2 * np.pi, 0.01)
        ]
    )
else:
    raise NotImplementedError(f"Projection type {args.projection_type} not known")

if pts1 is not None:
    pts1 = rot.apply(pts1)

    l1 = vedo.Line(pts1).c("yellow").lw(3)
else:
    l1 = vedo.Point(pos=pt).c("yellow")

# The rotation axis arrow
ar1 = vedo.Arrow(
    start_pt=(0, 0, 0),
    end_pt=(0, 0, 2),
    s=None,
    shaft_radius=0.005,
    head_radius=0.02,
    head_length=0.1,
    res=32,
    c="r4",
    alpha=1.0,
)

plt.show(
    E, sh, l1, ar1, camera={"pos": (6, 0, 6), "thickness": 1000, "viewup": [0, 0, 1]}
)
plt.screenshot(f"{args.projection_type}_{args.orientation_type}.png")
