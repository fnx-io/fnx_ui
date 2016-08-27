import 'dart:async';

Future cancelSubscription(StreamSubscription subscription) {
  if (subscription != null) {
    return subscription.cancel();
  } else {
    return new Future.value(true);
  }
}

///
/// This class is based on https://pub.dartlang.org/packages/throttle_debounce
/// by Shivanshu Agrawal.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
/// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE X CONSORTIUM BE LIABLE FOR ANY CLAIM,
/// DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
/// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
///
class FnxDebouncer {

  Duration delay;
  var callback;

  FnxDebouncer(this.delay, this.callback);

  var timer=null;

  void debounce() {

    void exec() {
      callback();
    }

    void clear() {
      timer = null;
    }

    //cancel the previous timer if debounce is still being called before the delay period is over
    if(timer != null) {
      timer.cancel();
    }

    //schedule a new call after delay time
    timer = new Timer(delay, exec);
  }

}