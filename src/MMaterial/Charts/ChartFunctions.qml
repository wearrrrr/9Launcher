pragma Singleton

import QtQuick

QtObject {
    function generateAdaptiveRangeNumbers(min, max, n) {
        const biggestAbs = Math.max(Math.abs(min), Math.abs(max));
        const magnitude = Math.floor(Math.log10(biggestAbs));
        const roundTo = Math.pow(10, magnitude);

        let start, end;
        if (min >= 0) {
            start = 0;
            end = Math.ceil(max / roundTo) * roundTo;
        } else {
            const range = Math.max(Math.abs(min), Math.abs(max));
            start = -Math.ceil(range / roundTo) * roundTo;
            end = Math.ceil(range / roundTo) * roundTo;
        }

        const step = (end - start) / (n - 1);

        const result = [];
        for (let i = 0; i < n; i++) {
            const value = Math.round((start + i * step) / roundTo) * roundTo;
            if (!result.includes(value)) {
                result.push(value);
            }
        }

        if (!result.includes(0)) {
            result.push(0);
            result.sort((a, b) => a - b);
        }

        return result;
    }

    function generateAdaptiveCloseRangeNumbers(min, max, n) {
        // Ensure min is always smaller than max
        if (min > max) {
            [min, max] = [max, min];
        }

        // Always include 0 in the range
        min = Math.min(min, 0);
        max = Math.max(max, 0);

        // Find the appropriate magnitude for rounding
        const range = max - min;
        const magnitude = Math.pow(10, Math.floor(Math.log10(range / n)));

        // Round min and max to the nearest lower and upper magnitude
        const roundedMin = Math.floor(min / magnitude) * magnitude;
        const roundedMax = Math.ceil(max / magnitude) * magnitude;

        // Generate the range
        const step = (roundedMax - roundedMin) / (n - 1);
        const result = [];

        for (let i = 0; i < n; i++) {
            result.push(Math.round((roundedMin + i * step) / magnitude) * magnitude);
        }

        return result;
    }

    function generateSpreadNumbers(min, max, n) {
        if (n < 2) {
            return []
        }

        if (min >= max) {
            return []
        }

        const result = [];
        const step = (max - min) / (n - 1);

        for (let i = 0; i < n; i++) {
            let value = min + step * i;
            result.push(Number(value.toFixed(2)));
        }

        result[0] = Number(min.toFixed(2));
        result[n - 1] = Number(max.toFixed(2));

        return result;
    }

    function calculateGrowthPercentage(a, b) {
        let percent;
        if(a === 0 && b === 0)
            percent = 0;
        else if(b !== 0) {
            if(a !== 0)
                percent = (b - a) / a * 100;
            else
                percent = b * 100;
        } else
            percent = - a * 100;

        let sign = a > b ? -1 : 1;
        return Math.floor(Math.abs(percent)) * sign;
    }
}
