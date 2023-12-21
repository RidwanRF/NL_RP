local waterPoses = {
	{-1584, -1826, 0, -1360, -1826, 0, -1584, -1642, 0, -1360, -1642, 0},
	{-3000, 354, 0, -2832, 354, 0, -3000, 2942, 0, -2832, 2942, 0},
	{-2832, 1296, 0, -2704, 1296, 0, -2832, 2192, 0, -2704, 2192, 0},
	{-2704, 1360, 0, -2240, 1360, 0, -2704, 2224, 0, -2240, 2224, 0},
	{-2240, 1432, 0, -2000, 1432, 0, -2240, 2224, 0, -2000, 2224, 0},
	{-2064, 1312, 0, -2000, 1312, 0, -2064, 1432, 0, -2000, 1432, 0},
	{-2000, 1392, 0, -1712, 1392, 0, -2000, 1792, 0, -1712, 1792, 0},
	{-2000, 1792, 0, -1724, 1792, 0, -2000, 2016, 0, -1724, 2016, 0},
	{-2000, 2016, 0, -1836, 2016, 0, -2000, 2176, 0, -1836, 2176, 0},
	{-2000, 2176, 0, -1920, 2176, 0, -2000, 2224, 0, -1920, 2224, 0},
	{-2208, 2224, 0, -2000, 2224, 0, -2208, 2432, 0, -2000, 2432, 0},
	{-2208, 2432, 0, -2000, 2432, 0, -2208, 2576, 0, -2000, 2576, 0},
	{-2352, 2448, 0, -2208, 2448, 0, -2352, 2576, 0, -2208, 2576, 0},
	{-2312, 2344, 0, -2208, 2344, 0, -2312, 2448, 0, -2208, 2448, 0},
	{-1712, 1360, 0, -1600, 1360, 0, -1712, 1792, 0, -1600, 1792, 0},
	{-1664, 1280, 0, -1600, 1280, 0, -1664, 1360, 0, -1600, 1360, 0},
	{-1600, 1280, 0, -1440, 1280, 0, -1600, 1696, 0, -1440, 1696, 0},
	{-1600, 1696, 0, -1488, 1696, 0, -1600, 1744, 0, -1488, 1744, 0},
	{-1440, 1440, 0, -1232, 1440, 0, -1440, 1696, 0, -1232, 1696, 0},
	{-1232, 1440, 0, -1136, 1440, 0, -1232, 1616, 0, -1136, 1616, 0},
	{-1440, 1280, 0, -1136, 1280, 0, -1440, 1440, 0, -1136, 1440, 0},
	{-1136, 1248, 0, -1104, 1248, 0, -1136, 1424, 0, -1104, 1424, 0},
	{-1520, 1104, 0, -1104, 1104, 0, -1520, 1248, 0, -1104, 1248, 0},
	{-1520, 1248, 0, -1136, 1248, 0, -1520, 1280, 0, -1136, 1280, 0},
	{-1600, 1200, 0, -1520, 1200, 0, -1600, 1280, 0, -1520, 1280, 0},
	{-1104, 944, 0, -932, 944, 0, -1104, 1136, 0, -932, 1136, 0},
	{-1424, 944, 0, -1104, 944, 0, -1424, 1104, 0, -1104, 1104, 0},
	{-1520, 1008, 0, -1424, 1008, 0, -1520, 1104, 0, -1424, 1104, 0},
	{-1424, 784, 0, -896, 784, 0, -1424, 944, 0, -896, 944, 0},
	{-1488, 560, 0, -896, 560, 0, -1488, 784, 0, -896, 784, 0},
	{-1536, 560, 0, -1488, 560, 0, -1536, 672, 0, -1488, 672, 0},
	{-896, 208, 0, -768, 208, 0, -896, 732, 0, -768, 732, 0},
	{-1600, 208, 0, -896, 208, 0, -1600, 560, 0, -896, 560, 0},
	{-992, -144, 0, -912, -144, 0, -992, 208, 0, -912, 208, 0},
	{-1748, -816, 0, -1180, -816, 0, -1748, -592, 0, -1180, -592, 0},
	{-1458, -592, 0, -1054, -592, 0, -1458, -432, 0, -1054, -432, 0},
	{-3000, -1186, 0, -2880, -1186, 0, -3000, -822, 0, -2880, -822, 0},
	{-2880, -1168, 0, -2768, -1168, 0, -2880, -896, 0, -2768, -896, 0},
	{-2768, -1106, 0, -2656, -1106, 0, -2768, -830, 0, -2656, -830, 0},
	{-2656, -1024, 0, -2512, -1024, 0, -2656, -816, 0, -2512, -816, 0},
	{-2512, -976, 0, -2400, -976, 0, -2512, -816, 0, -2400, -816, 0},
	{-2400, -1056, 0, -2256, -1056, 0, -2400, -864, 0, -2256, -864, 0},
	{-2256, -1198, 0, -2144, -1198, 0, -2256, -950, 0, -2144, -950, 0},
	{-2144, -1408, 0, -2000, -1408, 0, -2144, -1072, 0, -2000, -1072, 0},
	{-2000, -1536, 0, -1856, -1536, 0, -2000, -1280, 0, -1856, -1280, 0},
	{-1856, -1648, 0, -1728, -1648, 0, -1856, -1440, 0, -1728, -1440, 0},
	{-1728, -1728, 0, -1584, -1728, 0, -1728, -1520, 0, -1584, -1520, 0},
	{-1360, -2052, 0, -1216, -2052, 0, -1360, -1696, 0, -1216, -1696, 0},
	{-1440, -2110, 0, -1360, -2110, 0, -1440, -1950, 0, -1360, -1950, 0},
	{-1484, -2180, 0, -1440, -2180, 0, -1484, -2036, 0, -1440, -2036, 0},
	{-1572, -2352, 0, -1484, -2352, 0, -1572, -2096, 0, -1484, -2096, 0},
	{-1216, -2208, 0, -1104, -2208, 0, -1216, -1864, 0, -1104, -1864, 0},
	{-1232, -2304, 0, -1120, -2304, 0, -1232, -2208, 0, -1120, -2208, 0},
	{-1270, -2480, 0, -1178, -2480, 0, -1270, -2304, 0, -1178, -2304, 0},
	{-1260, -2560, 0, -1188, -2560, 0, -1260, -2480, 0, -1188, -2480, 0},
	{-1262, -2640, 0, -1146, -2640, 0, -1262, -2560, 0, -1146, -2560, 0},
	{-1216, -2752, 0, -1080, -2752, 0, -1216, -2640, 0, -1080, -2640, 0},
	{-1200, -2896, 0, -928, -2896, 0, -1200, -2752, 0, -928, -2752, 0},
	{-2016, -3000, 0, -1520, -3000, 0, -2016, -2704, 0, -1520, -2704, 0},
	{-1520, -3000, 0, -1376, -3000, 0, -1520, -2894, 0, -1376, -2894, 0},
	{-2256, -3000, 0, -2016, -3000, 0, -2256, -2772, 0, -2016, -2772, 0},
	{-2448, -3000, 0, -2256, -3000, 0, -2448, -2704, 0, -2256, -2704, 0},
	{-3000, -3000, 0, -2448, -3000, 0, -3000, -2704, 0, -2448, -2704, 0},
	{-3000, -2704, 0, -2516, -2704, 0, -3000, -2576, 0, -2516, -2576, 0},
	{-3000, -2576, 0, -2600, -2576, 0, -3000, -2448, 0, -2600, -2448, 0},
	{-3000, -2448, 0, -2628, -2448, 0, -3000, -2144, 0, -2628, -2144, 0},
	{-3000, -2144, 0, -2670, -2144, 0, -3000, -2032, 0, -2670, -2032, 0},
	{-3000, -2032, 0, -2802, -2032, 0, -3000, -1904, 0, -2802, -1904, 0},
	{-3000, -1904, 0, -2920, -1904, 0, -3000, -1376, 0, -2920, -1376, 0},
	{-3000, -1376, 0, -2936, -1376, 0, -3000, -1186, 0, -2936, -1186, 0},
	{-768, 208, 0, -720, 208, 0, -768, 672, 0, -720, 672, 0},
	{-720, 256, 0, -656, 256, 0, -720, 672, 0, -656, 672, 0},
	{-656, 276, 0, -496, 276, 0, -656, 576, 0, -496, 576, 0},
	{-496, 298, 0, -384, 298, 0, -496, 566, 0, -384, 566, 0},
	{-384, 254, 0, -224, 254, 0, -384, 530, 0, -224, 530, 0},
	{-224, 212, 0, -64, 212, 0, -224, 528, 0, -64, 528, 0},
	{-64, 140, 0, 64, 140, 0, -64, 544, 0, 64, 544, 0},
	{64, 140, 0, 304, 140, 0, 64, 544, 0, 304, 544, 0},
	{120, 544, 0, 304, 544, 0, 120, 648, 0, 304, 648, 0},
	{304, 164, 0, 384, 164, 0, 304, 608, 0, 384, 608, 0},
	{384, 222, 0, 464, 222, 0, 384, 630, 0, 464, 630, 0},
	{464, 304, 0, 544, 304, 0, 464, 656, 0, 544, 656, 0},
	{544, 362, 0, 800, 362, 0, 544, 646, 0, 800, 646, 0},
	{800, 432, 0, 944, 432, 0, 800, 704, 0, 944, 704, 0},
	{944, 480, 0, 976, 480, 0, 944, 720, 0, 976, 720, 0},
	{976, 528, 0, 1040, 528, 0, 976, 704, 0, 1040, 704, 0},
	{1040, 560, 0, 1280, 560, 0, 1040, 672, 0, 1280, 672, 0},
	{1280, 480, 0, 1472, 480, 0, 1280, 640, 0, 1472, 640, 0},
	{1472, 432, 0, 1616, 432, 0, 1472, 640, 0, 1616, 640, 0},
	{1616, 416, 0, 1824, 416, 0, 1616, 608, 0, 1824, 608, 0},
	{1824, 400, 0, 2160, 400, 0, 1824, 576, 0, 2160, 576, 0},
	{2160, 400, 0, 2432, 400, 0, 2160, 512, 0, 2432, 512, 0},
	{2432, 368, 0, 2560, 368, 0, 2432, 544, 0, 2560, 544, 0},
	{2560, 336, 0, 2720, 336, 0, 2560, 576, 0, 2720, 576, 0},
	{2720, 196, 0, 2816, 196, 0, 2720, 560, 0, 2816, 560, 0},
	{2816, 160, 0, 3000, 160, 0, 2816, 576, 0, 3000, 576, 0},
	{2860, -80, 0, 3000, -80, 0, 2860, 160, 0, 3000, 160, 0},
	{-1376, -3000, 0, -544, -3000, 0, -1376, -2896, 0, -544, -2896, 0},
	{-928, -2896, 0, -544, -2896, 0, -928, -2800, 0, -544, -2800, 0},
	{-544, -3000, 0, -320, -3000, 0, -544, -2824, 0, -320, -2824, 0},
	{-320, -3000, 0, -192, -3000, 0, -320, -2876, 0, -192, -2876, 0},
	{-192, -3000, 0, 160, -3000, 0, -192, -2920, 0, 160, -2920, 0},
	{-128, -2920, 0, 160, -2920, 0, -128, -2872, 0, 160, -2872, 0},
	{-60, -2872, 0, 160, -2872, 0, -60, -2816, 0, 160, -2816, 0},
	{-4, -2816, 0, 160, -2816, 0, -4, -2672, 0, 160, -2672, 0},
	{40, -2672, 0, 160, -2672, 0, 40, -2256, 0, 160, -2256, 0},
	{16, -2560, 0, 40, -2560, 0, 16, -2256, 0, 40, -2256, 0},
	{-32, -2440, 0, 16, -2440, 0, -32, -2256, 0, 16, -2256, 0},
	{-32, -2488, 0, 16, -2488, 0, -32, -2440, 0, 16, -2440, 0},
	{-96, -2440, 0, -32, -2440, 0, -96, -2256, 0, -32, -2256, 0},
	{-168, -2384, 0, -96, -2384, 0, -168, -2256, 0, -96, -2256, 0},
	{-224, -2256, 0, 160, -2256, 0, -224, -2080, 0, 160, -2080, 0},
	{-248, -2080, 0, 160, -2080, 0, -248, -1968, 0, 160, -1968, 0},
	{-280, -1968, 0, -128, -1968, 0, -280, -1824, 0, -128, -1824, 0},
	{-264, -2016, 0, -248, -2016, 0, -264, -1968, 0, -248, -1968, 0},
	{-264, -1824, 0, -128, -1824, 0, -264, -1640, 0, -128, -1640, 0},
	{-128, -1768, 0, 124, -1768, 0, -128, -1648, 0, 124, -1648, 0},
	{-128, -1792, 0, 140, -1792, 0, -128, -1768, 0, 140, -1768, 0},
	{-128, -1968, 0, 148, -1968, 0, -128, -1792, 0, 148, -1792, 0},
	{160, -2128, 0, 592, -2128, 0, 160, -1976, 0, 592, -1976, 0},
	{480, -1976, 0, 592, -1976, 0, 480, -1896, 0, 592, -1896, 0},
	{352, -1976, 0, 480, -1976, 0, 352, -1896, 0, 480, -1896, 0},
	{232, -1976, 0, 352, -1976, 0, 232, -1880, 0, 352, -1880, 0},
	{160, -1976, 0, 232, -1976, 0, 160, -1872, 0, 232, -1872, 0},
	{160, -2784, 0, 592, -2784, 0, 160, -2128, 0, 592, -2128, 0},
	{160, -3000, 0, 592, -3000, 0, 160, -2784, 0, 592, -2784, 0},
	{352, -1896, 0, 544, -1896, 0, 352, -1864, 0, 544, -1864, 0},
	{592, -2112, 0, 976, -2112, 0, 592, -1896, 0, 976, -1896, 0},
	{736, -1896, 0, 904, -1896, 0, 736, -1864, 0, 904, -1864, 0},
	{704, -1896, 0, 736, -1896, 0, 704, -1728, 0, 736, -1728, 0},
	{736, -1864, 0, 752, -1864, 0, 736, -1728, 0, 752, -1728, 0},
	{688, -1728, 0, 752, -1728, 0, 688, -1480, 0, 752, -1480, 0},
	{592, -2192, 0, 976, -2192, 0, 592, -2112, 0, 976, -2112, 0},
	{592, -2328, 0, 1008, -2328, 0, 592, -2192, 0, 1008, -2192, 0},
	{592, -3000, 0, 1008, -3000, 0, 592, -2328, 0, 1008, -2328, 0},
	{1008, -3000, 0, 1072, -3000, 0, 1008, -2368, 0, 1072, -2368, 0},
	{1008, -2368, 0, 1064, -2368, 0, 1008, -2320, 0, 1064, -2320, 0},
	{1072, -2672, 0, 1288, -2672, 0, 1072, -2412, 0, 1288, -2412, 0},
	{1072, -2768, 0, 1288, -2768, 0, 1072, -2672, 0, 1288, -2672, 0},
	{1072, -3000, 0, 1288, -3000, 0, 1072, -2768, 0, 1288, -2768, 0},
	{1288, -3000, 0, 1448, -3000, 0, 1288, -2760, 0, 1448, -2760, 0},
	{1288, -2760, 0, 1392, -2760, 0, 1288, -2688, 0, 1392, -2688, 0},
	{1448, -3000, 0, 1720, -3000, 0, 1448, -2754, 0, 1720, -2754, 0},
	{1720, -3000, 0, 2064, -3000, 0, 1720, -2740, 0, 2064, -2740, 0},
	{2064, -3000, 0, 2144, -3000, 0, 2064, -2742, 0, 2144, -2742, 0},
	{2144, -3000, 0, 2208, -3000, 0, 2144, -2700, 0, 2208, -2700, 0},
	{2208, -3000, 0, 2272, -3000, 0, 2208, -2684, 0, 2272, -2684, 0},
	{2272, -3000, 0, 2376, -3000, 0, 2272, -2312, 0, 2376, -2312, 0},
	{2376, -2480, 0, 2472, -2480, 0, 2376, -2240, 0, 2472, -2240, 0},
	{2472, -2376, 0, 2776, -2376, 0, 2472, -2240, 0, 2776, -2240, 0},
	{2776, -2336, 0, 2856, -2336, 0, 2776, -2192, 0, 2856, -2192, 0},
	{2808, -2560, 0, 3000, -2560, 0, 2808, -2336, 0, 3000, -2336, 0},
	{2856, -2336, 0, 3000, -2336, 0, 2856, -2136, 0, 3000, -2136, 0},
	{2888, -2136, 0, 3000, -2136, 0, 2888, -1840, 0, 3000, -1840, 0},
	{2872, -1880, 0, 2888, -1880, 0, 2872, -1840, 0, 2888, -1840, 0},
	{2864, -1840, 0, 3000, -1840, 0, 2864, -1720, 0, 3000, -1720, 0},
	{2888, -1720, 0, 3000, -1720, 0, 2888, -1664, 0, 3000, -1664, 0},
	{2896, -1664, 0, 3000, -1664, 0, 2896, -1592, 0, 3000, -1592, 0},
	{2920, -1592, 0, 3000, -1592, 0, 2920, -1504, 0, 3000, -1504, 0},
	{2940, -1504, 0, 3000, -1504, 0, 2940, -1344, 0, 3000, -1344, 0},
	{2908, -1344, 0, 3000, -1344, 0, 2908, -1096, 0, 3000, -1096, 0},
	{2912, -1096, 0, 3000, -1096, 0, 2912, -800, 0, 3000, -800, 0},
	{2918, -800, 0, 3000, -800, 0, 2918, -472, 0, 3000, -472, 0},
	{2872, -472, 0, 3000, -472, 0, 2872, -376, 0, 3000, -376, 0},
	{2912, -376, 0, 3000, -376, 0, 2912, -80, 0, 3000, -80, 0},
	{2864, -376, 0, 2912, -376, 0, 2864, -80, 0, 2912, -80, 0},
	{2560, -2560, 0, 2680, -2560, 0, 2560, -2456, 0, 2680, -2456, 0},
	{-992, -422, 0, -848, -422, 0, -992, -238, 0, -848, -238, 0},
	{-848, -384, 0, -512, -384, 0, -848, -256, 0, -512, -256, 0},
	{-512, -400, 0, -320, -400, 0, -512, -272, 0, -320, -272, 0},
	{-320, -400, 0, -208, -400, 0, -320, -304, 0, -208, -304, 0},
	{-384, -528, 0, -100, -528, 0, -384, -460, 0, -100, -460, 0},
	{-384, -704, 0, -64, -704, 0, -384, -528, 0, -64, -528, 0},
	{-336, -816, 0, -80, -816, 0, -336, -704, 0, -80, -704, 0},
	{-208, -936, 0, -48, -936, 0, -208, -816, 0, -48, -816, 0},
	{-48, -936, 0, 144, -936, 0, -48, -874, 0, 144, -874, 0},
	{32, -1024, 0, 128, -1024, 0, 32, -936, 0, 128, -936, 0},
	{-16, -1104, 0, 96, -1104, 0, -16, -1024, 0, 96, -1024, 0},
	{0, -1200, 0, 144, -1200, 0, 0, -1104, 0, 144, -1104, 0},
	{-16, -1296, 0, 128, -1296, 0, -16, -1200, 0, 128, -1200, 0},
	{-16, -1440, 0, 112, -1440, 0, -16, -1296, 0, 112, -1296, 0},
	{0, -1552, 0, 96, -1552, 0, 0, -1440, 0, 96, -1440, 0},
	{-128, -1648, 0, 96, -1648, 0, -128, -1552, 0, 96, -1552, 0},
	{-64, -672, 0, 32, -672, 0, -64, -576, 0, 32, -576, 0},
	{-64, -576, 0, 96, -576, 0, -64, -496, 0, 96, -496, 0},
	{16, -496, 0, 144, -496, 0, 16, -392, 0, 144, -392, 0},
	{144, -448, 0, 240, -448, 0, 144, -384, 0, 240, -384, 0},
	{240, -432, 0, 304, -432, 0, 240, -320, 0, 304, -320, 0},
	{304, -384, 0, 352, -384, 0, 304, -288, 0, 352, -288, 0},
	{352, -332, 0, 400, -332, 0, 352, -252, 0, 400, -252, 0},
	{400, -298, 0, 464, -298, 0, 400, -234, 0, 464, -234, 0},
	{464, -288, 0, 576, -288, 0, 464, -208, 0, 576, -208, 0},
	{576, -272, 0, 688, -272, 0, 576, -192, 0, 688, -192, 0},
	{688, -256, 0, 768, -256, 0, 688, -144, 0, 768, -144, 0},
	{768, -212, 0, 800, -212, 0, 768, -124, 0, 800, -124, 0},
	{800, -180, 0, 976, -180, 0, 800, -92, 0, 976, -92, 0},
	{976, -160, 0, 1200, -160, 0, 976, -64, 0, 1200, -64, 0},
	{1200, -244, 0, 1264, -244, 0, 1200, -108, 0, 1264, -108, 0},
	{1264, -330, 0, 1344, -330, 0, 1264, -158, 0, 1344, -158, 0},
	{1344, -320, 0, 1456, -320, 0, 1344, -208, 0, 1456, -208, 0},
	{1456, -282, 0, 1520, -282, 0, 1456, -198, 0, 1520, -198, 0},
	{1520, -208, 0, 1648, -208, 0, 1520, -80, 0, 1648, -80, 0},
	{1568, -80, 0, 1648, -80, 0, 1568, 16, 0, 1648, 16, 0},
	{1648, -64, 0, 1792, -64, 0, 1648, 16, 0, 1792, 16, 0},
	{1792, -128, 0, 1888, -128, 0, 1792, 0, 0, 1888, 0, 0},
	{1888, -268, 0, 2016, -268, 0, 1888, -20, 0, 2016, -20, 0},
	{2016, -256, 0, 2144, -256, 0, 2016, -16, 0, 2144, -16, 0},
	{2144, -272, 0, 2224, -272, 0, 2144, -96, 0, 2224, -96, 0},
	{2224, -272, 0, 2288, -272, 0, 2224, -144, 0, 2288, -144, 0},
	{2048, -16, 0, 2144, -16, 0, 2048, 112, 0, 2144, 112, 0},
	{2096, 112, 0, 2224, 112, 0, 2096, 240, 0, 2224, 240, 0},
	{2098, 240, 0, 2242, 240, 0, 2098, 400, 0, 2242, 400, 0},
	{2160, 512, 0, 2432, 512, 0, 2160, 576, 0, 2432, 576, 0},
	{2432, 544, 0, 2560, 544, 0, 2432, 592, 0, 2560, 592, 0},
	{2560, 576, 0, 2720, 576, 0, 2560, 608, 0, 2720, 608, 0},
	{2720, 560, 0, 2816, 560, 0, 2720, 608, 0, 2816, 608, 0},
	{2816, 576, 0, 3000, 576, 0, 2816, 752, 0, 3000, 752, 0},
	{-656, 576, 0, -496, 576, 0, -656, 672, 0, -496, 672, 0},
	{-740, 672, 0, -484, 672, 0, -740, 784, 0, -484, 784, 0},
	{-720, 784, 0, -384, 784, 0, -720, 1008, 0, -384, 1008, 0},
	{-640, 1008, 0, -400, 1008, 0, -640, 1216, 0, -400, 1216, 0},
	{-880, 1296, 0, -688, 1296, 0, -880, 1408, 0, -688, 1408, 0},
	{-688, 1216, 0, -400, 1216, 0, -688, 1424, 0, -400, 1424, 0},
	{-672, 1424, 0, -448, 1424, 0, -672, 1616, 0, -448, 1616, 0},
	{-832, 1616, 0, -512, 1616, 0, -832, 1728, 0, -512, 1728, 0},
	{-984, 1632, 0, -832, 1632, 0, -984, 1712, 0, -832, 1712, 0},
	{-832, 1728, 0, -576, 1728, 0, -832, 2032, 0, -576, 2032, 0},
	{2376, -3000, 0, 3000, -3000, 0, 2376, -2688, 0, 3000, -2688, 0},
	{2520, -2688, 0, 3000, -2688, 0, 2520, -2560, 0, 3000, -2560, 0},
	{-1248, -144, 0, -992, -144, 0, -1248, 208, 0, -992, 208, 0},
	{-1176, -432, 0, -992, -432, 0, -1176, -144, 0, -992, -144, 0},
	{-1792, -592, 0, -1728, -592, 0, -1792, -144, 0, -1728, -144, 0},
	{-1792, 170, 0, -1600, 170, 0, -1792, 274, 0, -1600, 274, 0},
	{-1600, 168, 0, -1256, 168, 0, -1600, 208, 0, -1256, 208, 0},
	{-1574, -44, 0, -1550, -44, 0, -1574, 108, 0, -1550, 108, 0},
	{1928, -1222, 18, 2012, -1222, 18, 1928, -1178, 18, 2012, -1178, 18},
	{-464, -1908, 0, -280, -1908, 0, -464, -1832, 0, -280, -1832, 0},
	{2248, -1182, 23.3374, 2260, -1182, 23.3374, 2248, -1170, 23.3374, 2260, -1170, 23.3374},
	{2292, -1432, 22.165, 2328, -1432, 22.165, 2292, -1400, 22.165, 2328, -1400, 22.165},
	{1270, -812, 86.673, 1290, -812, 86.673, 1270, -800, 86.673, 1290, -800, 86.673},
	{1084, -684, 112, 1104, -684, 112, 1084, -660, 112, 1104, -660, 112},
	{502, -1114, 78.4231, 522, -1114, 78.4231, 502, -1098, 78.4231, 522, -1098, 78.4231},
	{214, -1208, 74, 246, -1208, 74, 214, -1180, 74, 246, -1180, 74},
	{218, -1180, 74, 238, -1180, 74, 218, -1172, 74, 238, -1172, 74},
	{178, -1244, 77.0534, 206, -1244, 77.0534, 178, -1216, 77.0534, 206, -1216, 77.0534},
	{-2832, 2888, 0, 3000, 2888, 0, -2832, 3000, 0, 3000, 3000, 0},
	{-2778, -522, 2.79256, -2662, -522, 2.79256, -2778, -414, 2.79256, -2662, -414, 2.79256},
	{1520, -252, 0, 1572, -252, 0, 1520, -208, 0, 1572, -208, 0},
	{2922, 752, 0, 3000, 752, 0, 2922, 2888, 0, 3000, 2888, 0},
	{-3000, -446, 0, -2910, -446, 0, -3000, 354, 0, -2910, 354, 0},
	{-2434, 2224, 0, -2294, 2224, 0, -2434, 2340, 0, -2294, 2340, 0},
	{-2294, 2224, 0, -2208, 2224, 0, -2294, 2312, 0, -2208, 2312, 0},
	{-3000, 2942, 0, -2832, 2942, 0, -3000, 3000, 0, -2832, 3000, 0},
	{-896, 842, 0, -776, 842, 0, -896, 954, 0, -776, 954, 0},
	{-2240, 1336, 0, -2088, 1336, 0, -2240, 1432, 0, -2088, 1432, 0},
	{-3000, -822, 0, -2930, -822, 0, -3000, -446, 0, -2930, -446, 0},
	{-2660, 2224, 0, -2520, 2224, 0, -2660, 2264, 0, -2520, 2264, 0},
	{-378, -460, 0, -138, -460, 0, -378, -400, 0, -138, -400, 0},
	{890, -1106, 22.41, 902, -1106, 22.41, 890, -1098, 22.41, 902, -1098, 22.41},
	--{1202, -2414, 8.86445, 1278, -2414, 8.86445, 1202, -2334, 8.86445, 1278, -2334, 8.86445},----!!!! buggos
	{1072, -2412, 0, 1128, -2412, 0, 1072, -2372, 0, 1128, -2372, 0},
	{-848, -2082, 5.27, -664, -2082, 5.27, -848, -1866, 5.27, -664, -1866, 5.27},
	{-1484, 784, 0, -1424, 784, 0, -1484, 840, 0, -1424, 840, 0},
	{-496, 566, 0, -432, 566, 0, -496, 642, 0, -432, 642, 0},
	{250, 2808, 0, 818, 2808, 0, 250, 2888, 0, 818, 2888, 0},
	{2502, -2240, 0, 2670, -2240, 0, 2502, -2120, -5, 2670, -2120, -5},
	{1270, -780, 1082.72998, 1290, -780, 1082.72998, 1270, -768, 1082.72998, 1290, -768, 1082.72998},
	{88, 544, 0, 120, 544, 0, 88, 572, 0, 120, 572, 0},
	{1856, -202, 0, 1888, -202, 0, 1856, -158, 0, 1888, -158, 0},
	{-2048, -962, 30.4, -2004, -962, 30.4, -2048, -758, 30.4, -2004, -758, 30.4},
	{-2522, -310, 35.382, -2382, -310, 35.382, -2522, -234, 35.382, -2382, -234, 35.382},
	{2872, -2136, 0, 2888, -2136, 0, 2872, -2120, 0, 2888, -2120, 0},
	{2760, -2240, 0, 2776, -2240, 0, 2760, -2232, 0, 2776, -2232, 0},
	{-912, 208, 0, -724, 208, 0, -912, 20, 0},
	{-1610, 168, 0, -1550, 168, 0, -1550, 108, 0},
	{-1728, -62, 0, -1568, -62, 0, -1728, -222, 0},
	{-1724, 170, 0, -1612, 170, 0, -1724, 58, 0},
	{-1550, 168, 0, -1362, 168, 0, -1550, -20, 0},
	{-1722, -62, 0, -1574, -62, 0, -1574, 86, 0}
}

local createdWaters = {}

addEventHandler("onClientResourceStart", getResourceRootElement(),
	function ()
		setWaterLevel(-3000, true, false)
		
		for i = 1, #waterPoses do
			local poses = waterPoses[i]

			setWaterLevel(poses[1], poses[2], 0, poses[3])
			setWaterLevel(poses[4], poses[5], 0, poses[6])
			setWaterLevel(poses[7], poses[8], 0, poses[9])

			if #poses > 10 then
				setWaterLevel(poses[10], poses[11], 0, poses[12])
			end
		end

		createWater(-3000, 510, 0, 3000, 510, 0, -3000, 3000, 0, 3000, 3000, 0) -- lv fix

		-- sf reptér melletti dokk fix (stuntok elkerülése végett)
		createWater(-1696.5552978516, 46.57585144043, 0, -1661.7613525391, 46.57585144043, 0, -1696.5552978516, 72.634246826172, 0, -1661.7613525391, 72.634246826172, 0)
		createWater(-1696.3012695313, 72.835472106934, 0, -1571.7639160156, 72.835472106934, 0, -1696.3012695313, 141.8723449707, 0, -1571.7639160156, 141.8723449707, 0)
		createWater(-1661.1418457031, 51.416858673096, 0, -1638.2625732422, 51.416858673096, 0, -1661.1418457031, 75.924781799316, 0, -1638.2625732422, 75.924781799316, 0)
		createWater(-1633.2298583984, 132.98379516602, 0, -1579.2707519531, 132.98379516602, 0, -1633.2298583984, 146.20213317871, 0, -1579.2707519531, 146.20213317871, 0)
		createWater(-1636.3118896484, 125.31167602539, 0, -1597.8825683594, 125.31167602539, 0, -1636.3118896484, 167.6630859375, 0, -1597.8825683594, 167.6630859375, 0)
		createWater(-1599.2774658203, 122.114112854, 0, -1590.6958007813, 122.114112854, 0, -1599.2774658203, 167.85438537598, 0, -1590.6958007813, 167.85438537598, 0)
		createWater(-1610.3065185547, 139.66293334961, 0, -1572.3654785156, 139.66293334961, 0, -1610.3065185547, 161.42774963379, 0, -1572.3654785156, 161.42774963379, 0)

		createWater(1202, -2414, 8.86445, 1278, -2414, 8.86445, 1202, -2334, 8.86445, 1278, -2334, 8.86445) -- LS reptér melletti kis park fix (ez buggos alapból ezért van újrahozva)

		setWaveHeight(0.15)
	end
)