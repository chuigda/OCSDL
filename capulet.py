#!/usr/bin/env python

# 从 sprite(斯普莱特) 联想到 capulet(凯普莱特) 应该是很正常的事情

# 哦！罗密欧，你为什么是罗密欧！ 否认你的父亲，抛弃你的姓名吧；
# 也许你不愿意这样做，那么只要你宣誓做我的爱人，我也不愿再姓凯普莱特了。

import sys
from typing import List
import cv2


def main(args: List[str]):
    print(args)
    if len(args) < 3:
        raise Exception('what the hell are you thinking about? give me the fucking picture!')

    images = []
    for arg in args[1:]:
        image = cv2.imread(arg)
        images.append(image)

    first_image = images[0]
    eh, ew, _ = first_image.shape
    for idx, image in enumerate(images[1:]):
        h, w, _ = image.shape
        if eh != h or ew != w:
            raise Exception(
                'badly sized image '
                + str(idx + 1)
                + ': expected shape '
                + str(ew) + 'x' + str(eh)
                + ', got '
                + str(w) + 'x' + str(h)
            )

    output = cv2.hconcat(images)
    cv2.imwrite('output.png', output)


if __name__ == '__main__':
    main(sys.argv)
