local module = {
	SunSystem = {
		Sun = {
			Name = "Sun",
			Rotation = {
				RotationalPeriod = 25.05 * 24,
				RotationalAngle = 7.25,
			},
		},
	},
	MercurySystem = {
		Mercury = {
			Name = "Mercury",
			Rotation = {
				RotationalPeriod = 1407.6,
				RotationalAngle = 0.034,
			},
		},
	},
	VenusSystem = {
		Venus = {
			Name = "Venus",
			Rotation = {
				RotationalPeriod = 5832.6,
				RotationalAngle = 177.36,
			},
		},
	},
	EarthSystem = {
		Earth = {
			Name = "Earth",
			Rotation = {
				RotationalPeriod = 23.9345,
				RotationalAngle = 23.44,
			},
		},
		Moon = {
			Name = "Moon",
			Rotation = {
				TidallyLocked = true,
				RotationalPeriod = 5832.6,
				RotationalAngle = 177.36,
			},
			Orbit = {
				OrbitalPeriod = 655.720,
				OrbitalAngle = 5.145,
				OrbitalDistance = 384.4 * 2,
				TextureAdjustmentX = 180,
				TextureAdjustmentZ = 180,
				Retrograde = false,
			},
		},
	},
	MarsSystem = {
		Mars = {
			Name = "Mars",
			Rotation = {
				RotationalPeriod = 24.6229,
				RotationalAngle = 25.19,
			},
		},
		Phobos = {
			Name = "Phobos",
			Rotation = {
				TidallyLocked = true,
				RotationalPeriod = 7.65384,
				RotationalAngle = 177.36,
			},
			Orbit = {
				OrbitalPeriod = 7.65384,
				OrbitalAngle = 1.08,
				OrbitalDistance = 9.378 * 2,
				TextureAdjustmentX = 90,
				TextureAdjustmentZ = 0,
				Retrograde = false,
			},
		},
		Deimos = {
			Name = "Deimos",
			Rotation = {
				TidallyLocked = true,
				RotationalPeriod = 30.29856,
				RotationalAngle = 177.36,
			},
			Orbit = {
				OrbitalPeriod = 30.29856,
				OrbitalAngle = 1.79,
				OrbitalDistance = 23.459 * 2,
				TextureAdjustmentX = 0,
				TextureAdjustmentZ = 0,
				Retrograde = false,
			},
		},
	},
	JupiterSystem = {
		Jupiter = {
			Name = "Jupiter",
			Rotation = {
				RotationalPeriod = 9.9250,
				RotationalAngle = 3.13,
			},
		},
		Io = {
			Name = "Io",
			Rotation = {
				TidallyLocked = true,
				RotationalPeriod = 30.29856,
				RotationalAngle = 177.36,
			},
			Orbit = {
				OrbitalPeriod = 1.769130 * 24,
				OrbitalAngle = 0.04,
				OrbitalDistance = 421.8 * 2,
				TextureAdjustmentX = 0,
				TextureAdjustmentZ = 0,
				Retrograde = false,
			},
		},
		Europa = {
			Name = "Europa",
			Rotation = {
				TidallyLocked = true,
				RotationalPeriod = 30.29856,
				RotationalAngle = 177.36,
			},
			Orbit = {
				OrbitalPeriod = 3.551181 * 24,
				OrbitalAngle = 0.47,
				OrbitalDistance = 671.1 * 2,
				TextureAdjustmentX = 0,
				TextureAdjustmentZ = 0,
				Retrograde = false,
			},
		},
		Ganymede = {
			Name = "Ganymede",
			Rotation = {
				TidallyLocked = true,
				RotationalPeriod = 30.29856,
				RotationalAngle = 177.36,
			},
			Orbit = {
				OrbitalPeriod = 7.154553 * 24,
				OrbitalAngle = 0.18,
				OrbitalDistance = 1070.4 * 2,
				TextureAdjustmentX = 0,
				TextureAdjustmentZ = 0,
				Retrograde = false,
			},
		},
		Callisto = {
			Name = "Callisto",
			Rotation = {
				TidallyLocked = true,
				RotationalPeriod = 30.29856,
				RotationalAngle = 177.36,
			},
			Orbit = {
				OrbitalPeriod = 16.689017 * 24,
				OrbitalAngle = 0.19,
				OrbitalDistance = 1882.7 * 2,
				TextureAdjustmentX = 0,
				TextureAdjustmentZ = 0,
				Retrograde = false,
			},
		},
	},
	SaturnSystem = {
		Saturn = {
			Name = "Saturn",
			Rotation = {
				RotationalPeriod = 10.56,
				RotationalAngle = 26.73,
			},
		},
		Titan = {
			Name = "Titan",
			Rotation = {
				TidallyLocked = true,
				RotationalPeriod = 30.29856,
				RotationalAngle = 177.36,
			},
			Orbit = {
				OrbitalPeriod = 15.9454 * 24,
				OrbitalAngle = 0.3,
				OrbitalDistance = 1221.9 * 2,
				TextureAdjustmentX = 0,
				TextureAdjustmentZ = 0,
				Retrograde = false,
			},
		},
		Rhea = {
			Name = "Rhea",
			Rotation = {
				TidallyLocked = true,
				RotationalPeriod = 30.29856,
				RotationalAngle = 177.36,
			},
			Orbit = {
				OrbitalPeriod = 4.51750 * 24,
				OrbitalAngle = 0.3,
				OrbitalDistance = 527.2 * 2,
				TextureAdjustmentX = 0,
				TextureAdjustmentZ = 0,
				Retrograde = false,
			},
		},
		Iapetus = {
			Name = "Iapetus",
			Rotation = {
				TidallyLocked = true,
				RotationalPeriod = 30.29856,
				RotationalAngle = 177.36,
			},
			Orbit = {
				OrbitalPeriod = 79.3310 * 24,
				OrbitalAngle = 7.6,
				OrbitalDistance = 3561.7 * 2,
				TextureAdjustmentX = 0,
				TextureAdjustmentZ = 0,
				Retrograde = false,
			},
		},
		Dione = {
			Name = "Dione",
			Rotation = {
				TidallyLocked = true,
				RotationalPeriod = 30.29856,
				RotationalAngle = 177.36,
			},
			Orbit = {
				OrbitalPeriod = 2.73692 * 24,
				OrbitalAngle = 0,
				OrbitalDistance = 377 * 2,
				TextureAdjustmentX = 0,
				TextureAdjustmentZ = 0,
				Retrograde = false,
			},
		},
		Tethys = {
			Name = "Tethys",
			Rotation = {
				TidallyLocked = true,
				RotationalPeriod = 30.29856,
				RotationalAngle = 177.36,
			},
			Orbit = {
				OrbitalPeriod = 1.88780 * 24,
				OrbitalAngle = 1.1,
				OrbitalDistance = 295 * 2,
				TextureAdjustmentX = 0,
				TextureAdjustmentZ = 0,
				Retrograde = false,
			},
		},
		Enceladus = {
			Name = "Enceladus",
			Rotation = {
				TidallyLocked = true,
				RotationalPeriod = 30.29856,
				RotationalAngle = 177.36,
			},
			Orbit = {
				OrbitalPeriod = 1.37022 * 24,
				OrbitalAngle = 0,
				OrbitalDistance = 238 * 2,
				TextureAdjustmentX = 0,
				TextureAdjustmentZ = 0,
				Retrograde = false,
			},
		},
		Mimas = {
			Name = "Mimas",
			Rotation = {
				TidallyLocked = true,
				RotationalPeriod = 30.29856,
				RotationalAngle = 177.36,
			},
			Orbit = {
				OrbitalPeriod = 0.94242 * 24,
				OrbitalAngle = 1.6,
				OrbitalDistance = 186 * 2,
				TextureAdjustmentX = 0,
				TextureAdjustmentZ = 0,
				Retrograde = false,
			},
		},
	},
	UranusSystem = {
		Uranus = {
			Name = "Uranus",
			Rotation = {
				RotationalPeriod = 0.718661 * 24,
				RotationalAngle = 82.23,
			},
		},
		Titania = {
			Name = "Titania",
			Rotation = {
				TidallyLocked = true,
				RotationalPeriod = 30.29856,
				RotationalAngle = 177.36,
			},
			Orbit = {
				OrbitalPeriod = 8.7059 * 24,
				OrbitalAngle = 0.114,
				OrbitalDistance = 436.2 * 2,
				TextureAdjustmentX = 0,
				TextureAdjustmentZ = 0,
				Retrograde = false,
			},
		},
		Oberon = {
			Name = "Oberon",
			Rotation = {
				TidallyLocked = true,
				RotationalPeriod = 30.29856,
				RotationalAngle = 177.36,
			},
			Orbit = {
				OrbitalPeriod = 13.463 * 24,
				OrbitalAngle = 0.125,
				OrbitalDistance = 583.5 * 2,
				TextureAdjustmentX = 0,
				TextureAdjustmentZ = 0,
				Retrograde = false,
			},
		},
		Umbriel = {
			Name = "Umbriel",
			Rotation = {
				TidallyLocked = true,
				RotationalPeriod = 30.29856,
				RotationalAngle = 177.36,
			},
			Orbit = {
				OrbitalPeriod = 4.1442 * 24,
				OrbitalAngle = 0.083,
				OrbitalDistance = 265.9 * 2,
				TextureAdjustmentX = 0,
				TextureAdjustmentZ = 0,
				Retrograde = false,
			},
		},
		Ariel = {
			Name = "Ariel",
			Rotation = {
				TidallyLocked = true,
				RotationalPeriod = 30.29856,
				RotationalAngle = 177.36,
			},
			Orbit = {
				OrbitalPeriod = 2.5204 * 24,
				OrbitalAngle = 0.026,
				OrbitalDistance = 190.9 * 2,
				TextureAdjustmentX = 0,
				TextureAdjustmentZ = 0,
				Retrograde = false,
			},
		},
		Miranda = {
			Name = "Miranda",
			Rotation = {
				TidallyLocked = true,
				RotationalPeriod = 30.29856,
				RotationalAngle = 177.36,
			},
			Orbit = {
				OrbitalPeriod = 1.4135 * 24,
				OrbitalAngle = 4.421,
				OrbitalDistance = 129.8 * 2,
				TextureAdjustmentX = 0,
				TextureAdjustmentZ = 0,
				Retrograde = false,
			},
		},
	},
	NeptuneSystem = {
		Neptune = {
			Name = "Neptune",
			Rotation = {
				RotationalPeriod = 0.673 * 24,
				RotationalAngle = 28.32,
			},
		},
		Triton = {
			Name = "Triton",
			Rotation = {
				TidallyLocked = true,
				RotationalPeriod = 30.29856,
				RotationalAngle = 177.36,
			},
			Orbit = {
				OrbitalPeriod = 5.8769 * 24,
				OrbitalAngle = 156.865,
				OrbitalDistance = 354.759 * 2,
				TextureAdjustmentX = 0,
				TextureAdjustmentZ = 0,
				Retrograde = false,
			},
		},
	},
	PlutoSystem = {
		Pluto = {
			Name = "Pluto",
			Rotation = {
				RotationalPeriod = 9.9250,
				RotationalAngle = 3.13,
			},
		},
		Charon = {
			Name = "Charon",
			Rotation = {
				TidallyLocked = true,
				RotationalPeriod = 30.29856,
				RotationalAngle = 177.36,
			},
			Orbit = {
				OrbitalPeriod = 1.769130 * 24,
				OrbitalAngle = 0.04,
				OrbitalDistance = 421.8 * 2,
				TextureAdjustmentX = 0,
				TextureAdjustmentZ = 0,
				Retrograde = false,
			},
		},
	},
}

return module
