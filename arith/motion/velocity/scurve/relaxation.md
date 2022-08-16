# velocity relaxation

## relaxation

- S>S60
  - S70
  - S60
  - Am>An
    - Am: s>s51
        - s60
        - vm>am
          - s>s32
            - S51
            - S32
            - failed
          - S>S40
            - S51
            - S>S22
              - S40
              - S22
              - failed
    - An: s>s52
        - s60
        - vm>an
          - s>s31
            - S52
            - S31
            - failed
          - S>S40
            - S52
            - S>S21
              - S40
              - S21
              - failed
- S>S51
  - S61
  - vm>am
    - s>s32
      - S51
      - S32
      - failed
    - S>S40
      - S51
      - S>S22
        - S40
        - S22
        - failed
- S>S52
  - S62
  - vm>an
    - s>s31
      - S52
      - S31
      - failed
    - S>S40
      - S52
      - S>S21
        - S40
        - S21
        - failed
- S>S40
  - S50
  - v0>vd
    - s>s22
      - s40
      - s22
      - failed
    - s>s21
      - s40
      - s21
      - failed

主要是这四种路径
- s22->s40 ->s51->s60
- s32->s51
- s21->s40 ->s52->s60
- s31->s52

但是，s40有多种大小排列。

