cols = ['plate_x', 'plate_z', 'hit_flag']

_df = df_batted[df_batted.batter_name == 'Mike Trout'][cols]
_df = _df.dropna(axis=0, how='any')

print(_df.shape)

X = _df[['plate_x', 'plate_z']]
y = _df['hit_flag']

gam = LogisticGAM(fit_intercept=False, n_splines=100, constraints='concave').fit(X, y)

delta = 0.2
x = np.arange(-2, 2, delta)
y = np.arange(0.5, 5, delta)
X, Y = np.meshgrid(x, y)

print(X.shape)

Z = np.zeros(X.shape, dtype=np.float64)
zx, zy = Z.shape

for x in range(zx):
    for y in range(zy):
        xc = X[x, y]
        yc = Y[x, y]
        
        prob = gam.predict_proba([[xc + delta/2, yc + delta/2]])
        
        Z[x, y] = prob

plt.figure()

contour = plt.contourf(X, Y, Z)

cbar = plt.colorbar(contour)

plt.title('Batting average by location')
plt.axes().set_aspect('equal', 'datalim')
plt.show()
