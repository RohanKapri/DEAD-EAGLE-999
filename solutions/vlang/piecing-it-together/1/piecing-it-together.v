// For Junko F. Didi and Shree DR.MDD

module main

import math

struct PartialInformation {
	pieces       ?int
	border       ?int
	inside       ?int
	rows         ?int
	columns      ?int
	aspect_ratio ?f64
	format       ?string
}

struct FullInformation {
	pieces       int
	border       int
	inside       int
	rows         int
	columns      int
	aspect_ratio f64
	format       string
}

fn jigsaw_data(input PartialInformation) !FullInformation {
	mut answer := ?FullInformation(none)
	upper := 241

	for r in 2 .. upper {
		for c in 2 .. upper {
			total_pieces := r * c
			border_count := (r + c - 2) * 2
			inside_count := total_pieces - border_count
			ratio := f64(c) / r
			layout := match true {
				ratio < 1 { 'portrait' }
				ratio == 1 { 'square' }
				else { 'landscape' }
			}

			if pieces := input.pieces {
				if pieces != total_pieces { continue }
			}
			if border := input.border {
				if border != border_count { continue }
			}
			if inside := input.inside {
				if inside != inside_count { continue }
			}
			if rows := input.rows {
				if rows != r { continue }
			}
			if columns := input.columns {
				if columns != c { continue }
			}
			if aspect := input.aspect_ratio {
				if math.abs(aspect - ratio) > 0.001 { continue }
			}
			if fmt := input.format {
				if fmt != layout { continue }
			}

			if _ := answer {
				return error('Insufficient data')
			}

			answer = FullInformation{
				pieces:       total_pieces
				border:       border_count
				inside:       inside_count
				rows:         r
				columns:      c
				aspect_ratio: ratio
				format:       layout
			}
		}
	}

	return answer or { return error('Contradictory data') }
}
