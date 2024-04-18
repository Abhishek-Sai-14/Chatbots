from app import predict
import streamlit as st

st.markdown("<h1 style='text-align: center;'>Sarcasm Detector</h1>",
            unsafe_allow_html=True)
text = st.text_area(label='Enter your comment')
btn = st.button(label='Detect')

try:
    if text is not None:
        if btn:
            out = predict(str(text))
            print(out)
            if out > 0.42:
                msg = "Well..You don't have to be soo sarcastic. 🙄"
            else:
                msg = "Not enough sarcasm detected. Try harder! 😜"
            st.markdown("<h3 style='text-align: center;'>{}</h3>".format(msg),
                        unsafe_allow_html=True)

except Exception as e:
    st.write(e)
